Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA8303A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391997AbhAZKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbhAZBeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:34:10 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0423C0698CF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:22:27 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h11so30485907ioh.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1PipcbfAZi1zl/MYuhsQR5QeK+Th3Jp83jqSTIEX24=;
        b=S3R99dyZDE45n5Z813wbq/dUqTCcUe20nk0q0pkFAHFkc+pnIxU82xT+V7whGOL0mn
         6x3SAtzcAkW5Ij9QKpweBHxSfFQB7b1YmXOYg+D9PhI7d5Rt1eMw8m+MY+zsJedjCj+N
         YfJrRW644KFpeJqvFNYGSZXDFyGoVe2tMqkU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1PipcbfAZi1zl/MYuhsQR5QeK+Th3Jp83jqSTIEX24=;
        b=Fo+0wym7GQs/022cF3mYnl7h6B+bXedlPQaWX3NA+b4gSQi8AACcKL7rimw7LfypeJ
         suMIqDvwUPIPO+k9Pu/t+Kqa6PbG/4R2tNcTXcMqvnr9kZd6nhWAG8BdQOsZoQLSmQfS
         MrpHCdMoaU8pvRl0BvQGHxSX0CIbjkPiy1sTeHry9aquQaIbSwbNNtTHg/iM1TwygTVK
         Iew4lroUYjPCJ0J0VlrCuGAhv9h6RPc4q65w7YyziN2hkU+Hc3X6e5rDQphDjwwzuvct
         DRPZobisg0BRCR8SqyO17kcOHw/YLv1dt9/C29kg1Kihp5e5kIX/yJ5uyUPEK+rKPwi7
         dEUQ==
X-Gm-Message-State: AOAM533HYXqPqUqh2RtgrSA2SBOjWYF9mz+yRWXl8wmoJQiqIuZfYhRI
        vfvmAz/uHBFP+hRzwpO94ZXG+A/MpESyfg==
X-Google-Smtp-Source: ABdhPJwgMKxknI44sx2fSv2m3L5pEyIOezryeq9Ih2ND7e2d0Nr20Pqr+zVl1v+CpnPC2zEhhlSg2w==
X-Received: by 2002:a92:6410:: with SMTP id y16mr2675926ilb.126.1611624146922;
        Mon, 25 Jan 2021 17:22:26 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c25sm11466896iom.11.2021.01.25.17.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 17:22:26 -0800 (PST)
Subject: Re: [PATCH v4 01/17] selftests/resctrl: Fix compilation issues for
 global variables
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
 <20201130202010.178373-2-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f79c885b-b67f-09ca-69f9-726cd6211e53@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 18:22:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-2-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:19 PM, Fenghua Yu wrote:
> Reinette reported following compilation issue on Fedora 32, gcc version
> 10.1.1
> 
> /usr/bin/ld: cqm_test.o:<src_dir>/cqm_test.c:22: multiple definition of
> `cache_size'; cat_test.o:<src_dir>/cat_test.c:23: first defined here
> 
> The same issue is reported for long_mask, cbm_mask, count_of_bits etc
> variables as well. Compiler isn't happy because these variables are
> defined globally in two .c files namely cqm_test.c and cat_test.c and
> the compiler during compilation finds that the variable is already
> defined (multiple definition error).
> 
> Taking a closer look at the usage of these variables reveals that these
> variables are used only locally to functions such as cqm_resctrl_val()
> (defined in cqm_test.c) and cat_perf_miss_val() (defined in cat_test.c).
> These variables are not shared between those functions. So, there is no
> need for these variables to be global. Hence, fix this issue by making
> them local variables to the functions where they are used.
> 

Easy fix to this problem would be making these variables static to
these files. I am not seeing any real advantage to changing these
variable to local variables.

diff --git a/tools/testing/selftests/resctrl/cat_test.c 
b/tools/testing/selftests/resctrl/cat_test.c
index 5da43767b973..360456b8a1b6 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,10 +17,10 @@
  #define MAX_DIFF_PERCENT       4
  #define MAX_DIFF               1000000

-int count_of_bits;
-char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
+static int count_of_bits;
+static cbm_mask[256];
+static unsigned long long_mask;
+static unsigned long cache_size;

Same changes made to tools/testing/selftests/resctrl/cqm_test.c

> To fix issues for other global variables (e.g: bm_pid, ppid, llc_occup_path
> and is_amd) that are used across .c files, declare them as extern.
> 

This change is fine. Make this a separate patch.

This way, we can take it as a fixes to stables.

With the above the test builds fine. There is a bigger problem that
needs fixing: (thix might have been fixed in later patches perhaps):

cqm_test.c: In function ‘check_results’:
cqm_test.c:89:9: warning: ‘fgets’ writing 1024 bytes into a region of 
size 512 overflows the destination [-Wstringop-overflow=]
    89 |  while (fgets(temp, 1024, fp)) {
       |         ^~~~~~~~~~~~~~~~~~~~~
In file included from resctrl.h:5,
                  from cqm_test.c:11:
/usr/include/stdio.h:568:14: note: in a call to function ‘fgets’ 
declared with attribute ‘write_only (1, 2)’
   568 | extern char *fgets (char *__restrict __s, int __n, FILE 
*__restrict __stream)
       |              ^~~~~


thanks,
-- Shuah
