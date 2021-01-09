Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5E2F0422
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbhAIWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:41:46 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA45C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 14:41:06 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id m23so13842059ioy.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gp32TEZc9lOHzZbbrbwhTeJG9xU53IajnNczJo48pmk=;
        b=AkUDNQG1FZxpLhUBl1EPvwcyg+098fOFLq7ZdW11lbYnNq8vgDKNfp9jBkYyPuADH6
         JhUPY1+XKxs8lgL8k78Ba97nc0/OSf1EdgUVTyRyPs0zm7lawL86KUNrfSxkBIUBtUEE
         ixtiKEMwiyLntFUVz6j1F2urrrlmRflBzf90Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gp32TEZc9lOHzZbbrbwhTeJG9xU53IajnNczJo48pmk=;
        b=ffRVvsX//zQDEl/Ay9q7e+9yBsKGpsPrv4zpqVortClQyW2nfoebX8P1k0DpFuPBPP
         /wSSM3fAedBJQjLWJsHQ0eAKAAQjHsNvL3gJ9v6a2fhKPP3ryVF9xVxHGUsLOuyqbxLz
         qLfWejn+IxDRDfFzOFC8OgcLcW5nCJP/Kkp5YqlPkF0T66LK+3F1p3vV0UZ88CBj0f6G
         wr5yCMqnolCcz/sYrjrM/MQwY8nyucC/NbPbDjoTAn1XPld1fvTi+4/YKmW1QyvaxRA2
         3jsV4bBHrnAuaXFLoifJcRghfH/B6kJ1c76A7bVQ4PUlgR9tSjtUhy11pnWKdAcHF08c
         LIkQ==
X-Gm-Message-State: AOAM532ob9xQtJDXWgvyrZJANBSd3dNFwPpL4SpnndINHBoA+bIfa7mj
        Kgr63vvMjspS0Pqnd+wSLAahCEDHqLo5Hw==
X-Google-Smtp-Source: ABdhPJzT2XjjP/3G333ywvrrGCsFz5dR9rdcxOJUxmv+a/UkRlZrIS4FcSxDZ/yVE6nOhxbcE3hroQ==
X-Received: by 2002:a05:6602:387:: with SMTP id f7mr10221423iov.209.1610232065243;
        Sat, 09 Jan 2021 14:41:05 -0800 (PST)
Received: from sunraycer.home ([2601:246:4400:318::100])
        by smtp.gmail.com with ESMTPSA id w2sm6041495ioa.46.2021.01.09.14.41.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 Jan 2021 14:41:04 -0800 (PST)
Received: from puyallup.local (localhost [127.0.0.1])
        by sunraycer.home (Postfix) with ESMTPA id DD808366BC5;
        Sat,  9 Jan 2021 16:41:03 -0600 (CST)
From:   Steve Magnani <magnani@ieee.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <magnani@ieee.org>
Subject: [PATCH 0/2] udf: fix hole append when File Tail exists
Date:   Sat,  9 Jan 2021 16:40:52 -0600
Message-Id: <20210109224054.5694-1-magnani@ieee.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven J. Magnani <magnani@ieee.org>

Fixes: fa33cdbf3ece ("udf: Fix incorrect final NOT_ALLOCATED (hole) extent length")

The fix for incorrect final NOT_ALLOCATED (hole) extent length did not
consider the possibility that an ALLOCATED_NOT_RECORDED extent
("File Tail") may follow the extents describing the file body.

A ftruncate() that adds a hole to the end of such a file now causes the
File Tail to grow into the block that follows it...even if that block
is already in use. The block is not marked as allocated (in the space
bitmap) as part of this process and so can later end up being double-
allocated for some other use (i.e., an ICB or file/directory data).

Other side-effects in this scenario include a failure to reclaim allocated
File Tail blocks when the file is released, and associated misreporting of
the number of recorded blocks in the file's Extended File Entry.

The kernel does not give any indication of any of these issues.
However, an attempt to read the file in Windows 10 fails with
"The file or directory is corrupted and unreadable."

The script below creates a toy UDF filesystem to illustrate the problem.
The filesystem can be dd'd to a flash disk partition of the same size
to observe how Windows handles the corruption.
---
#!/bin/bash

# Tool to illustrate / test fix for bugs in UDF driver
# related to creation of an end-of-file hole.
# Developed using mkudffs from udftools 2.2.

# Terminology:
#  LSN == Logical Sector Number (media / volume relative)
#  LBN == Logical Block Number  (UDF partition relative)


TEST_UDFFS=/tmp/test.udf

# Changing these may alter filesystem layout and/or invalidate the test
UDFFS_SIZE=1M        # --size argument to 'truncate' command
UDF_BLOCKSIZE=512
PD_LSN=98            # Expected UDF Partition Descriptor location
EFE_LSN=261          # Location of Extended File Entry under test
SBD_LSN=257          # Location of Space Bitmap Descriptor

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

# Extract an 8-bit unsigned value at a specified byte offset ($2)
# of a specified LSN ($1). Hex format can be output by passing x for $3.
# 
extract8()
{
    local format=${3:-u}   # Default to unsigned int
    local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=1 | od -A none -t ${format}1`
    [ -z "$value" ] && value=0   # Fail in a sane manner

    echo -n $value
}

# Extract a 16-bit little-endian unsigned value at a specified byte offset ($2)
# of a specified LSN ($1). Hex format can be output by passing x for $3.
# 
extract16()
{
    local format=${3:-u}   # Default to unsigned int
    local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=2 | od -A none -t ${format}2 --endian=little`
    [ -z "$value" ] && value=0   # Fail in a sane manner

    echo -n $value
}

# Extract a 32-bit little-endian unsigned value at a specified byte offset ($2)
# of a specified LSN ($1). Hex format can be output by passing x for $3.
# 
extract32()
{
    local format=${3:-u}   # Default to unsigned int
    local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=4 | od -A none -t ${format}4 --endian=little`
    [ -z "$value" ] && value=0   # Fail in a sane manner

    echo -n $value
}


# Extract a 64-bit little-endian unsigned value at a specified byte offset ($2)
# of a specified LSN ($1). Hex format can be output by passing x for $3.
# 
extract64()
{
    local format=${3:-u}   # Default to unsigned int
    local value=`ddq if=$TEST_UDFFS bs=$UDF_BLOCKSIZE skip=$1 count=1 | ddq bs=1 skip=$2 count=8 | od -A none -t ${format}8 --endian=little`
    [ -z "$value" ] && value=0   # Fail in a sane manner

    echo -n $value
}

read_extent_start_lbn()
{
    local extent_lbn_offset=$((220 + $2 * 16))
    extract32 $1 $extent_lbn_offset
}

# $1 == LSN of EFE
# $2 == Extent index of interest
read_extent_type()
{
    local extent_type_offset=$((219 + $2 * 16))
    local type_byte=`extract8 $1 $extent_type_offset`
    expr $type_byte / 64
}

# $1 == LSN of EFE
# $2 == Extent index of interest
read_extent_len()
{
    local extent_len_offset=$((216 + $2 * 16))
    local extent_typelen=`extract32 $1 $extent_len_offset`
    local extent_type=`read_extent_type $1 $2`
    echo $(($extent_typelen & 0x3FFFFFFF))
}


# $1 == LSN of EFE
# $2 == Extent index of interest
# $3 == Expected length field (including type) of extent - 8 lowercase hex digits
verify_extent_typelen()
{
    local extent_len_offset=$((216 + $2 * 16))
    local found_extent_len=`extract32 $1 $extent_len_offset x`
    if [ $found_extent_len != $3 ] ; then
        echo FAILURE: expected extent[$2] type/length $3, but EFE has $found_extent_len
        exitcode=1
    fi 
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
    openssl rand 1536
    ddq if=/dev/zero bs=$UDF_BLOCKSIZE count=1
    openssl rand 16384
    ddq if=/dev/zero bs=2102 count=1

    PROVOKER_RECORDED_BLOCKS=$(( (1536 + $UDF_BLOCKSIZE - 1) / $UDF_BLOCKSIZE ))
    PROVOKER_RECORDED_BLOCKS=$(( $PROVOKER_RECORDED_BLOCKS + ( 16384 + $UDF_BLOCKSIZE - 1 ) / $UDF_BLOCKSIZE ))
    PROVOKER_NUM_EXTENTS=4
}

# $1 == loopback UDF filesystem to create
make_test_udf()
{
    rm -f $1
    truncate --size=$UDFFS_SIZE $1
    mkudffs --label=SPARSE --uid=$UID --blocksize=$UDF_BLOCKSIZE $1 > /dev/null

    mkdir -p /tmp/testudf.mnt
    echo -n Mounting test UDF filesystem...
    sudo mount $1 /tmp/testudf.mnt
    echo
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
require_tag_id  $PD_LSN   5
require_tag_id $SBD_LSN 264   
require_tag_id $EFE_LSN 266

# Make sure EFE is for the created file
PROVOKER_LEN=`ls -l /tmp/provoker.$$ | cut -d' ' -f5`
EFE_FILE_INFO_LEN=`extract64 $EFE_LSN 56`
rm -f /tmp/provoker.$$
if [ $PROVOKER_LEN -ne $EFE_FILE_INFO_LEN ] ; then
    echo Expected file info len $PROVOKER_LEN in EFE at LSN $EFE_LSN, found $EFE_FILE_INFO_LEN.
    echo Unexpected test conditions - results must be verified manually
    exit 1
fi

EFE_ALLOC_DESC_LEN=`extract32 $EFE_LSN 212`
EFE_NUM_EXTENTS=$(($EFE_ALLOC_DESC_LEN / 16))
if [ $EFE_NUM_EXTENTS -ne $PROVOKER_NUM_EXTENTS ] ; then
    echo Expected $PROVOKER_NUM_EXTENTS file extents, but EFE says $EFE_NUM_EXTENTS
    echo Unexpected test conditions - results must be verified manually
    exit 1
fi

exitcode=0
EFE_RECORDED_BLOCKS=`extract64 $EFE_LSN 72`
if [ $EFE_RECORDED_BLOCKS -ne $PROVOKER_RECORDED_BLOCKS ] ; then
    echo FAILURE: expected $PROVOKER_RECORDED_BLOCKS recorded blocks, but EFE says $EFE_RECORDED_BLOCKS
    exitcode=1
fi

verify_extent_typelen $EFE_LSN 0 00000600   # Recorded, 3 blocks
verify_extent_typelen $EFE_LSN 1 80000200   # Not allocated, 512 bytes
verify_extent_typelen $EFE_LSN 2 00004000   # Recorded, 32 blocks
verify_extent_typelen $EFE_LSN 3 80000836   # Not allocated, 2102 bytes

if [ `read_extent_type $EFE_LSN 3` -ne 2 ] ; then
    # Verify that space bitmap considers last block of the final (allocated) extent used
    LAST_EXTENT_FIRST_LBN=`read_extent_start_lbn $EFE_LSN 3`
    LAST_EXTENT_BYTE_LEN=`read_extent_len $EFE_LSN 3`
    LAST_EXTENT_BLOCK_LEN=$(( ($LAST_EXTENT_BYTE_LEN + $UDF_BLOCKSIZE - 1) / $UDF_BLOCKSIZE ))
    LAST_EXTENT_LAST_LBN=$(($LAST_EXTENT_FIRST_LBN + $LAST_EXTENT_BLOCK_LEN - 1))
    BITMAP_BYTE_INDEX=$(($LAST_EXTENT_LAST_LBN / 8))
    LAST_LBN_MASK=$((1 << ($LAST_EXTENT_LAST_LBN - 8 * $BITMAP_BYTE_INDEX) ))
    SBD_BYTE_INDEX=$((24 + $BITMAP_BYTE_INDEX))
    BITMAP_BYTE=`extract8 $SBD_LSN $SBD_BYTE_INDEX`
    if [ $(($BITMAP_BYTE & $LAST_LBN_MASK)) -ne 0 ] ; then
        echo FAILURE: Space bitmap indicates LBN $LAST_EXTENT_LAST_LBN is free, but it is in use
        exitcode=1
    fi
fi

[ $exitcode -eq 0 ] && echo Test PASSED.
exit $exitcode
