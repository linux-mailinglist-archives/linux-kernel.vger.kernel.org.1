Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F031F2EE9E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbhAGXnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbhAGXnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:43:13 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C61C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:41:37 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id t8so7939544iov.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yk2xlHTH7n+jcQ7R6z3uiQveZjVkvnkD66qvxBmPplw=;
        b=ehyA5BGNvfdAR/lXcAkcJUWYxNd858geJzJBaA/f00KEgFC2K7Yco+Z1DX+5/qJC3p
         I88PvOsOFnJzWlEd0oFL641XuODFxj8gdc0ehgM8pSQNq6Wlgi4qNxSfJcC88qq/cZ1L
         PGJWY5D6/CpIPZfWDUiobzM/s8UxAxqBvJN4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yk2xlHTH7n+jcQ7R6z3uiQveZjVkvnkD66qvxBmPplw=;
        b=BoS6Mshp9/VgXo+DaGp2v/beI6ON4T6Th8ZOKl1iXdipCfdbgPYCt73FfoPW/3co3h
         QigBY2DIeWEz7RZ1zQP68bVM3kGF89ejbkQ6wlsMVbF/3Lg6+/ftjG52yTYVZYGNbe1n
         xm+zyA31K2cXzUYCGyQf4dtpMoJT46iNsFzhuQn949+mdwGTQcDJTIP/B5SPixP/AvW3
         dqKwZ+IxEeaDBGSlyCYdk/zas24AQoutCAdfLPG6yeo+/xqFRr18RJjLR8Rv0JSZf4Bk
         0DrokUJz0VCRKeA0QPe+FTXkGce4XSXCCOpuZr0Tz+vHf4DSLhux/DIv10fGl3cLFIih
         laVA==
X-Gm-Message-State: AOAM5313mkQZZIjuthZ9oiekQzhNWkY39j/QUvvtnTx8ixkP3EgpQwCE
        IKW5q55cVRSBiJDdhfGGBS6JpQ==
X-Google-Smtp-Source: ABdhPJzoZVDfw29tCnkVX0Rl3SvT6jrE+gvqs0ejJBWNq/BoPllE4oNVjFyaZKbU2rB3m4RccxjCrg==
X-Received: by 2002:a05:6638:f92:: with SMTP id h18mr885968jal.118.1610062897070;
        Thu, 07 Jan 2021 15:41:37 -0800 (PST)
Received: from sunraycer.home ([2601:246:4400:318::100])
        by smtp.gmail.com with ESMTPSA id j65sm5764717ilg.53.2021.01.07.15.41.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Jan 2021 15:41:36 -0800 (PST)
Received: from puyallup.local (localhost [127.0.0.1])
        by sunraycer.home (Postfix) with ESMTPA id B712535E7AC;
        Thu,  7 Jan 2021 17:41:35 -0600 (CST)
From:   Steve Magnani <magnani@ieee.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <magnani@ieee.org>
Subject: [PATCH 0/1] udf: fix silent AED tagLocation corruption
Date:   Thu,  7 Jan 2021 17:41:15 -0600
Message-Id: <20210107234116.6190-1-magnani@ieee.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven J. Magnani <magnani@ieee.org>

Certain scenarios involving enlargement of a large and/or fragmented file
result in corruption of the file's Allocation Extent Descriptor tag.
Once this has happened, attempts to read the file in Windows 10 fail with
"Data error (cyclic redundancy check)". A "chkdsk /f" in Windows causes
extents of the file described by the corrupted AED (and any subsequent
chained AEDs) to be truncated.

No problems are noted when the file is accessed in Linux.

The script below creates a toy UDF filesystem to illustrate the problem.
The filesystem can be dd'd to a flash disk partition of the same size
to observe how Windows handles the corruption.
---
#!/bin/bash

# Tool to illustrate / test fix for bug in UDF driver
# that can result in corruption of Allocation Extent Descriptor tag location
# Developed using mkudffs from udftools 2.2.

# Terminology:
#  LSN == Logical Sector Number (media / volume relative)
#  LBN == Logical Block Number  (UDF partition relative)


TEST_UDFFS=/tmp/test.udf

# Changing these may alter filesystem layout and/or invalidate the test
UDFFS_SIZE=1M        # --size argument to 'truncate' command
UDF_BLOCKSIZE=512
PD_LSN=98            # Expected UDF Partition Descriptor location
AED_LSN=1343         # Location of Allocation Extent Descriptor under test

require()
{
    local APP_REALPATH=`which $1`
    local PACKAGE_NAME=${2:-$1}
    if [ -z "$APP_REALPATH" ] ; then
        echo This test requires $1. Please install the $PACKAGE_NAME package.
        exit 1
    fi 
}

# "Quiet" dd command
ddq()
{
    dd $* 2> /dev/null
}

# Extract a 16-bit little-endian unsigned value at a specified byte offset ($2)
# of a specified LSN ($1)
# 
extract16()
{
    local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=2 | od -A none -t u2 --endian=little`
    [ -z "$value" ] && value=0   # Fail in a sane manner

    echo -n $value
}

# Extract a 32-bit little-endian unsigned value at a specified byte offset ($2)
# of a specified LSN ($1)
# 
extract32()
{
    local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=4 | od -A none -t u4 --endian=little`
    [ -z "$value" ] && value=0   # Fail in a sane manner

    echo -n $value
}


# $1 = LSN
# $2 = Expected tag ID value (decimal) - i.e., 266 for EFE
require_tag_id()
{
    local found_tag=`extract16 $1 0`

    if [ $found_tag -ne $2 ] ; then
        echo Expected tag $2 in LSN $1, found $found_tag.
        echo Unexpected test conditions - results must be verified manually
        exit 1
    fi
}

gen_provoker_data()
{
    ddq if=/dev/zero bs=$UDF_BLOCKSIZE count=1 of=/tmp/hole.$$

    openssl rand 172032
    cat /tmp/hole.$$
    openssl rand 149504
    cat /tmp/hole.$$
    openssl rand 22528
    cat /tmp/hole.$$
    openssl rand 2048
    cat /tmp/hole.$$
    openssl rand 4096
    cat /tmp/hole.$$
    openssl rand 4096
    cat /tmp/hole.$$
    openssl rand 8192
    cat /tmp/hole.$$
    openssl rand 184320
    cat /tmp/hole.$$
    openssl rand 131072

    rm -f /tmp/hole.$$
}

# $1 == loopback UDF filesystem to create
make_test_udf()
{
    rm -f $1
    truncate --size=$UDFFS_SIZE $1
    mkudffs --label=SPARSE --uid=$UID --blocksize=$UDF_BLOCKSIZE $1 > /dev/null

    mkdir -p /tmp/testudf.mnt
    echo Mounting test UDF filesystem. Please provide the root password if prompted.
    sudo mount $1 /tmp/testudf.mnt
    cp --sparse=always /tmp/provoker.$$ /tmp/testudf.mnt/provoker
    sync
    sudo umount /tmp/testudf.mnt
    rmdir /tmp/testudf.mnt
    echo Test UDF filesystem generated in $1.
}

### MAIN

require openssl
require mkudffs  udftools

if [ -e $TEST_UDFFS ] ; then
    echo $TEST_UDFFS already exists - please dismount and remove it
    exit 1
fi

gen_provoker_data > /tmp/provoker.$$
make_test_udf $TEST_UDFFS

# Verify hardcoded LSNs involved in testing
require_tag_id  $PD_LSN   5  # PD
require_tag_id $AED_LSN 258  # AED

LBN_BASE=`extract32 $PD_LSN 188`   # Partition Starting Location
AED_LBN=`expr $AED_LSN - $LBN_BASE`
AED_TAG_LOCATION=`extract32 $AED_LSN 12`

if [ $AED_TAG_LOCATION -ne $AED_LBN ] ; then
    echo Test FAILED: expected AED tag location $AED_LBN, actual is $AED_TAG_LOCATION
    exit 1
else
    echo Test PASSED. AED tag location field is correct.
fi
------------------------------------------------------------------------
 Steven J. Magnani               "I claim this network for MARS!
                                  Earthling, return my space modulator!"
 #include <standard.disclaimer>

