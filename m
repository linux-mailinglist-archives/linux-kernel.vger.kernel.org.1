Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2429D4EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgJ1Vzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgJ1Vys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:48 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D24C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:54:46 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id g7so987433ilr.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+bPcjkE2LVvE1S9DHK/44sPSiMl3Agmljqghbm1BJA=;
        b=XvOPCvBe+/l29dhLk+GdU320nX+TYX8gpkBGik4OML59fTK5mRJTXm3dUbJTGTata/
         y1RXyi4oApdYxQV0Em/q2E/juCAYj1yAhkRaM0OOfw3SR5ZgDmrRm2kZknUiu4pp/t3R
         O0envp0rG4Yg8yyejP2Kv7k79egzL/KRgXWnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+bPcjkE2LVvE1S9DHK/44sPSiMl3Agmljqghbm1BJA=;
        b=fNwCDqBWjql9KTXllfWBzJ4TLBm8ye7/eq5msXnRlDjWALPTGDVJtIyFKw0DdMko3q
         409oc7hWlBe+5UimbrRLCzvbxfQgMEoGY+ZdesNpvNHA3x0JDpPl5XHX1ZyBc4b/kkfc
         V+w3wuJvv9EspAMjM4DWCsz2OOL3WeRxyiwSAHxFlEJykaSWc7tojddMIv2aTcY5vad+
         MdnMnlc9O/XtvlMzLStgLCBfDMdghxu65Qod7kXXNeEPKP8/U2Ve8V61QrO8hYaSMuNh
         0x+LjQIVAWv0zJ5B2cwAUp9WmeFdQPcoW/e2dH/fYhfqJfeUrkyNpXB2TdYZ46GZuOuW
         TowA==
X-Gm-Message-State: AOAM5325idnI/eBRauMzt7o8xHUBnRFd2ZHb+WOHwwiW7an+S40vxHK+
        xna/Ui4/fVcKrWcqx7sIyars1yo6OniV5w==
X-Google-Smtp-Source: ABdhPJyikOuQn42ZMGpH1yzv4D5VzSSVW1A/W0mHa8GOSOvs0WhOgM7RqHqpN9/07/EP1hAgbMqZlQ==
X-Received: by 2002:a92:ad0f:: with SMTP id w15mr3521796ilh.97.1603845989333;
        Tue, 27 Oct 2020 17:46:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e4sm1796075ill.70.2020.10.27.17.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 17:46:28 -0700 (PDT)
Subject: Re: [PATCH v3 00/21] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c4fe6c5a-e5c4-0653-9e35-ab03f5494744@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 18:46:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 5:51 PM, Fenghua Yu wrote:
> This patch set has several miscellaneous fixes to resctrl selftest tool
> that are easily visible to user. V1 had fixes to CAT test and CMT test
> but they were dropped in V2 because having them here made the patchset
> humongous. So, changes to CAT test and CMT test will be posted in another
> patchset.
> 

This is still a very long patch series. Several of the patches can be
combined and can be rearranged. 21 patches don't seem to any specific
order.

> Change Log:
> v3:
> Address various comments (commit messages, return value on test failure,
> print failure info on test failure etc) from Reinette and Tony.
> [v2: https://lore.kernel.org/linux-kselftest/cover.1589835155.git.sai.praneeth.prakhya@intel.com/]
> 
> v2:
> 1. Dropped changes to CAT test and CMT test as they will be posted in a later
>     series.
> 2. Added several other fixes
> [v1: https://lore.kernel.org/linux-kselftest/cover.1583657204.git.sai.praneeth.prakhya@intel.com/]
> 
> Fenghua Yu (18):
>    selftests/resctrl: Rename CQM test as CMT test
>    selftests/resctrl: Declare global variables as extern
>    selftests/resctrl: Return if resctrl file system is not supported
>    selftests/resctrl: Check for resctrl mount point only if resctrl FS is
>      supported
>    selftests/resctrl: Use resctrl/info for feature detection
>    selftests/resctrl: Fix missing options "-n" and "-p"
>    selftests/resctrl: Fix MBA/MBM results reporting format
>    selftests/resctrl: Abort running tests if not root user
>    selftests/resctrl: Enable gcc checks to detect buffer overflows
>    selftests/resctrl: Don't hard code value of "no_of_bits" variable

>    selftests/resctrl: Modularize resctrl test suite main() function

Yes. This is a needed change. I didn't make it to this patch yet.

>    selftests/resctrl: Skip the test if requested resctrl feature is not
>      supported

Commented on this patch already. Look into using config file like other
tests.

>    selftests/resctrl: Umount resctrl FS only if mounted
>    selftests/resctrl: Unmount resctrl FS after running all tests
>    selftests/resctrl: Fix incorrect parsing of iMC counters
>    selftests/resctrl: Fix checking for < 0 for unsigned values
>    selftests/resctrl: Fix unnecessary usage of global variables
>    selftests/resctrl: Don't use global variable for capacity bitmask
>      (CBM)
> 
> Reinette Chatre (3):
>    selftests/resctrl: Fix typo
>    selftests/resctrl: Fix typo in help text

Why not combine the above two patches. The commit summary doesn't
make sense.

>    selftests/resctrl: Ensure sibling CPU is not same as original CPU
> 
>   tools/testing/selftests/resctrl/Makefile      |   2 +-
>   tools/testing/selftests/resctrl/README        |   4 +-
>   tools/testing/selftests/resctrl/cache.c       |   4 +-
>   tools/testing/selftests/resctrl/cat_test.c    |  20 +--
>   .../resctrl/{cqm_test.c => cmt_test.c}        |  34 ++--
>   tools/testing/selftests/resctrl/mba_test.c    |  23 ++-
>   tools/testing/selftests/resctrl/mbm_test.c    |  16 +-
>   tools/testing/selftests/resctrl/resctrl.h     |  20 ++-
>   .../testing/selftests/resctrl/resctrl_tests.c | 156 ++++++++++++------
>   tools/testing/selftests/resctrl/resctrl_val.c |  75 ++++++---
>   tools/testing/selftests/resctrl/resctrlfs.c   |  79 ++++++---
>   11 files changed, 272 insertions(+), 161 deletions(-)
>   rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (85%)
> 

I will review rest of the patches. Try to combine a few patches and
collapse fixes. I would like to see all the fixes first and then
renaming from CQM to CMT.

thanks,
-- Shuah
