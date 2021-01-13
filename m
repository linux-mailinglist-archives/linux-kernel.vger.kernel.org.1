Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7302F5161
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbhAMRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:47:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:50518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbhAMRrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:47:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF7B1AD11;
        Wed, 13 Jan 2021 17:47:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 58E0F1E0883; Wed, 13 Jan 2021 18:47:06 +0100 (CET)
Date:   Wed, 13 Jan 2021 18:47:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <magnani@ieee.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] udf: fix silent AED tagLocation corruption
Message-ID: <20210113174706.GI6854@quack2.suse.cz>
References: <20210107234116.6190-1-magnani@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107234116.6190-1-magnani@ieee.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for the fixes! This is just to let you know that I haven't forgotten
about them but I need to think a bit about them. Hopefully I'll be able to
find more time for them tomorrow.

								Honza

On Thu 07-01-21 17:41:15, Steve Magnani wrote:
> From: Steven J. Magnani <magnani@ieee.org>
> 
> Certain scenarios involving enlargement of a large and/or fragmented file
> result in corruption of the file's Allocation Extent Descriptor tag.
> Once this has happened, attempts to read the file in Windows 10 fail with
> "Data error (cyclic redundancy check)". A "chkdsk /f" in Windows causes
> extents of the file described by the corrupted AED (and any subsequent
> chained AEDs) to be truncated.
> 
> No problems are noted when the file is accessed in Linux.
> 
> The script below creates a toy UDF filesystem to illustrate the problem.
> The filesystem can be dd'd to a flash disk partition of the same size
> to observe how Windows handles the corruption.
> ---
> #!/bin/bash
> 
> # Tool to illustrate / test fix for bug in UDF driver
> # that can result in corruption of Allocation Extent Descriptor tag location
> # Developed using mkudffs from udftools 2.2.
> 
> # Terminology:
> #  LSN == Logical Sector Number (media / volume relative)
> #  LBN == Logical Block Number  (UDF partition relative)
> 
> 
> TEST_UDFFS=/tmp/test.udf
> 
> # Changing these may alter filesystem layout and/or invalidate the test
> UDFFS_SIZE=1M        # --size argument to 'truncate' command
> UDF_BLOCKSIZE=512
> PD_LSN=98            # Expected UDF Partition Descriptor location
> AED_LSN=1343         # Location of Allocation Extent Descriptor under test
> 
> require()
> {
>     local APP_REALPATH=`which $1`
>     local PACKAGE_NAME=${2:-$1}
>     if [ -z "$APP_REALPATH" ] ; then
>         echo This test requires $1. Please install the $PACKAGE_NAME package.
>         exit 1
>     fi 
> }
> 
> # "Quiet" dd command
> ddq()
> {
>     dd $* 2> /dev/null
> }
> 
> # Extract a 16-bit little-endian unsigned value at a specified byte offset ($2)
> # of a specified LSN ($1)
> # 
> extract16()
> {
>     local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=2 | od -A none -t u2 --endian=little`
>     [ -z "$value" ] && value=0   # Fail in a sane manner
> 
>     echo -n $value
> }
> 
> # Extract a 32-bit little-endian unsigned value at a specified byte offset ($2)
> # of a specified LSN ($1)
> # 
> extract32()
> {
>     local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=4 | od -A none -t u4 --endian=little`
>     [ -z "$value" ] && value=0   # Fail in a sane manner
> 
>     echo -n $value
> }
> 
> 
> # $1 = LSN
> # $2 = Expected tag ID value (decimal) - i.e., 266 for EFE
> require_tag_id()
> {
>     local found_tag=`extract16 $1 0`
> 
>     if [ $found_tag -ne $2 ] ; then
>         echo Expected tag $2 in LSN $1, found $found_tag.
>         echo Unexpected test conditions - results must be verified manually
>         exit 1
>     fi
> }
> 
> gen_provoker_data()
> {
>     ddq if=/dev/zero bs=$UDF_BLOCKSIZE count=1 of=/tmp/hole.$$
> 
>     openssl rand 172032
>     cat /tmp/hole.$$
>     openssl rand 149504
>     cat /tmp/hole.$$
>     openssl rand 22528
>     cat /tmp/hole.$$
>     openssl rand 2048
>     cat /tmp/hole.$$
>     openssl rand 4096
>     cat /tmp/hole.$$
>     openssl rand 4096
>     cat /tmp/hole.$$
>     openssl rand 8192
>     cat /tmp/hole.$$
>     openssl rand 184320
>     cat /tmp/hole.$$
>     openssl rand 131072
> 
>     rm -f /tmp/hole.$$
> }
> 
> # $1 == loopback UDF filesystem to create
> make_test_udf()
> {
>     rm -f $1
>     truncate --size=$UDFFS_SIZE $1
>     mkudffs --label=SPARSE --uid=$UID --blocksize=$UDF_BLOCKSIZE $1 > /dev/null
> 
>     mkdir -p /tmp/testudf.mnt
>     echo Mounting test UDF filesystem. Please provide the root password if prompted.
>     sudo mount $1 /tmp/testudf.mnt
>     cp --sparse=always /tmp/provoker.$$ /tmp/testudf.mnt/provoker
>     sync
>     sudo umount /tmp/testudf.mnt
>     rmdir /tmp/testudf.mnt
>     echo Test UDF filesystem generated in $1.
> }
> 
> ### MAIN
> 
> require openssl
> require mkudffs  udftools
> 
> if [ -e $TEST_UDFFS ] ; then
>     echo $TEST_UDFFS already exists - please dismount and remove it
>     exit 1
> fi
> 
> gen_provoker_data > /tmp/provoker.$$
> make_test_udf $TEST_UDFFS
> 
> # Verify hardcoded LSNs involved in testing
> require_tag_id  $PD_LSN   5  # PD
> require_tag_id $AED_LSN 258  # AED
> 
> LBN_BASE=`extract32 $PD_LSN 188`   # Partition Starting Location
> AED_LBN=`expr $AED_LSN - $LBN_BASE`
> AED_TAG_LOCATION=`extract32 $AED_LSN 12`
> 
> if [ $AED_TAG_LOCATION -ne $AED_LBN ] ; then
>     echo Test FAILED: expected AED tag location $AED_LBN, actual is $AED_TAG_LOCATION
>     exit 1
> else
>     echo Test PASSED. AED tag location field is correct.
> fi
> ------------------------------------------------------------------------
>  Steven J. Magnani               "I claim this network for MARS!
>                                   Earthling, return my space modulator!"
>  #include <standard.disclaimer>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
