Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A48B2AEF35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKKLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgKKLJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:09:34 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B714C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:09:34 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so1423959pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sByY2OvAaT/H3gvT3BLVuYjmUPC1XvQi52xpeyAO4Jc=;
        b=FuI7BvyNGtACkk1D23zYS56f/cUaCWJ/bOeGSW91XCx+LuUL2i9qdN/ETxtdBGUPIA
         tb9GfjxXZGl5ZV6JQ2X8FaMcJHgpgUz2m1UqSDxCkoqS/a37Xk5NHKVpONTxfLM9Zkgd
         /99sdlhoIyTz63s0kWnE6jYWI+h4tUOh4tiHaNNRI8uvcO+eVxCZT2lVrDnfMZmfCsfR
         Bs2iblIDL56PfToSHS9GX+YiiNZA2AAA+zL9BNO0Ap2GFEl/858VFTgStA2mse5YUNVp
         PERE7qx/RmF4Nho4a660Hhz4fUBrlIfTjMi8Q6SexD2lNJqtWsoyv4CnRBnyTzkQytRQ
         J3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sByY2OvAaT/H3gvT3BLVuYjmUPC1XvQi52xpeyAO4Jc=;
        b=e06txRhVBaf0VPLYU5pMf0lrhjQ6X+3tInLLFQREtXj80DBZgjWigkYTlKafgYrKYA
         WXfExOvWyhWSzXk/pjv3itcRpZi802F0gy+dS1W9NIYFm/M0+TojhKXsZDob/Cn4sfTZ
         1NMBm34m9mRJACNbZTbkndmTg5Y8T6408Is6RtJnalCKjO8epPuGlrHvQP3BwD50eGQ8
         2tC116ob/m5+YqVXRjzEatbV66AgOS2hIvH8oNDJuAfy2EppISmk2h0SEqg6msFFqC2r
         Ko0P6xXYanpshjacU34cj9yd6RVa8xVPHRzBg6KGLIXpGnHg85D7iw99cjn6UQblJw/q
         O6Bg==
X-Gm-Message-State: AOAM530oewvNB98QNgxKo4xdMyX1HJrboR85sgoZIBfG4Z0j1abMoiwb
        /V9oKP1AjiLoIuV1+ey7VBBinYdiluiZI2nX
X-Google-Smtp-Source: ABdhPJwj77gEOrvqKYrfDfRZVc4d90j01rRqqHqyjozwT/sAU2K0PJxMlG4LYP7/r2SX3fqTELdfow==
X-Received: by 2002:a62:7883:0:b029:18a:e054:edf1 with SMTP id t125-20020a6278830000b029018ae054edf1mr22365958pfc.70.1605092973449;
        Wed, 11 Nov 2020 03:09:33 -0800 (PST)
Received: from ?IPv6:2402:3a80:41c:a166:90d7:ac69:6d50:789e? ([2402:3a80:41c:a166:90d7:ac69:6d50:789e])
        by smtp.gmail.com with ESMTPSA id w16sm2236330pfn.45.2020.11.11.03.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 03:09:33 -0800 (PST)
Subject: Re: [PATCH v2] checkpatch: add fix option for MISSING_SIGN_OFF
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201111090143.9230-1-yashsri421@gmail.com>
 <CAKXUXMzg6Wg310s-N8hWOEiXFkg1ZAga+NkFQkFQ5_bS16TLnA@mail.gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <2b640e8b-69dc-2ade-3b9f-fae14eed1b17@gmail.com>
Date:   Wed, 11 Nov 2020 16:39:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMzg6Wg310s-N8hWOEiXFkg1ZAga+NkFQkFQ5_bS16TLnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 4:00 pm, Lukas Bulwahn wrote:
> On Wed, Nov 11, 2020 at 10:01 AM Aditya Srivastava <yashsri421@gmail.com> wrote:
>>
>> Currently checkpatch warns us if there is no 'Signed-off-by' line
>> for the patch.
>>
>> E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
>> Completely remove --version flag") reports this error:
>>
>> ERROR: Missing Signed-off-by: line(s)
>>
>> Provide a fix by adding a Signed-off-by line corresponding to the author
>> of the patch before the patch separator line. Also avoid this error for
>> the commits where some typo is present in the sign off.
>>
>> E.g. for commit 8cde5d5f7361 ("bus: ti-sysc: Detect omap4 type timers
>> for quirk") we get missing sign off as well as bad sign off for:
>>
>> Siganed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> Here it is probably best to give BAD_SIGN_OFF warning for Non-standard
>> signature and avoid MISSING_SIGN_OFF
>>
>> Suggested-by: Joe Perches <joe@perches.com>
>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>> ---
>> Changes in v2:
>> Add space after 'if'
>> Add check for $patch_separator_linenr to be greater than 0
>>
>>  scripts/checkpatch.pl | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index cb46288127ac..ac7e5ac80b58 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2404,6 +2404,8 @@ sub process {
>>
>>         my $last_blank_line = 0;
>>         my $last_coalesced_string_linenr = -1;
>> +       my $patch_separator_linenr = 0;
>> +       my $non_standard_signature = 0;
>>
>>         our @report = ();
>>         our $cnt_lines = 0;
>> @@ -2755,6 +2757,10 @@ sub process {
>>                 if ($line =~ /^---$/) {
>>                         $has_patch_separator = 1;
>>                         $in_commit_log = 0;
>> +                       # to add missing sign off line before diff(s)
>> +                       if ($patch_separator_linenr == 0) {
>> +                               $patch_separator_linenr = $linenr;
>> +                       }
>>                 }
>>
>>  # Check if MAINTAINERS is being updated.  If so, there's probably no need to
>> @@ -2775,6 +2781,9 @@ sub process {
>>                         if ($sign_off !~ /$signature_tags/) {
>>                                 WARN("BAD_SIGN_OFF",
>>                                      "Non-standard signature: $sign_off\n" . $herecurr);
>> +
>> +                               # to avoid missing_sign_off error as it most probably is just a typo
>> +                               $non_standard_signature = 1;
>>                         }
>>                         if (defined $space_before && $space_before ne "") {
>>                                 if (WARN("BAD_SIGN_OFF",
>> @@ -7118,9 +7127,12 @@ sub process {
>>                       "Does not appear to be a unified-diff format patch\n");
>>         }
>>         if ($is_patch && $has_commit_log && $chk_signoff) {
>> -               if ($signoff == 0) {
>> -                       ERROR("MISSING_SIGN_OFF",
>> -                             "Missing Signed-off-by: line(s)\n");
>> +               if ($signoff == 0 && !$non_standard_signature) {
>> +                       if (ERROR("MISSING_SIGN_OFF",
>> +                                 "Missing Signed-off-by: line(s)\n") &&
>> +                           $fix && $patch_separator_linenr > 0) {
>> +                               fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");
>> +                       }
> 
> Maybe I am already digging too much in the details... however:
> 
> I think it should still warn about a Missing Signed-off-by: even when
> we know there is a $non_standard_signature. So, checkpatch simply
> emits two warnings; that is okay in that case.
> 
> It is just that our evaluation shows that the provided fix option
> should not be suggested when there is a $non_standard_signature
> because we actually would predict that there is typo in the intended
> Signed-off-by tag and the fix that checkpatch would suggest would not
> be adequate.
> 
> Joe, what is your opinion?
> 
> Aditya, it should not be too difficult to implement the rule that way, right?
> 

No, I'd probably just have to add the check with $fix, instead of with
$signoff

Thanks
Aditya

> 
>>                 } elsif ($authorsignoff != 1) {
>>                         # authorsignoff values:
>>                         # 0 -> missing sign off
>> --
>> 2.17.1
>>

