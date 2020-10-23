Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63129778E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755694AbgJWTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbgJWTPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:15:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F45C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:15:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h7so2142784pfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KzL5VVv9OBTE8cblb6xc9qq9hjO17uW0mb/l3hbABK8=;
        b=T3R3ffmKYTWAmta7ZNbr9pjO+4nVjqBUiHz+11QNzUW4zabMSWsW5/5bfdR+p5FLbK
         iGr7AfcuXf6t5YGpJsJ1XcSK8rYkTWtxt/or9cVbFLHYrktaZbi7SCqqN3odTeSZnNWo
         keFGZgB+p1ULtiVPznwAcZdzwmpHgsVi456s7SyFRifx116kygD3JflHPOb3+XvEaj9e
         HSzwbcFHW01IABmjsmhjdkOl/HnhM+YFO0+bnrow8zihgql5CYPbCsZJQSk697j6Xgfq
         6zqilTWuduJkwoXWvNMfRICZhByyzTCsvskfO6ulJsnG/Si55V486uv46wNaVPPYtjcA
         gQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KzL5VVv9OBTE8cblb6xc9qq9hjO17uW0mb/l3hbABK8=;
        b=Ofu9h8q6+fUOyrlIyGQ6c0AiFXeClOEzpi4DU0j4jOCNWIpS9PhJcCVjx8r+aGz4jx
         OIEKlhSxcm6qG5YKP6Gn7PKJNj6DL2dnc5AEahQgU1OP+efScWBdfCcd3CeF9k4OlpFl
         +rNm6HOiniZS6L2n6fiha9f8hdH4Mfu0PJkYKISY37VaDuEkUmKDEX6mgZJfqwAc9jFf
         Vl9lrOakKWqSPXuNiytV+Xz+4VZtvJaOB0olkJissn0FfNIBIscXXqa3c/a/7Av2xpTb
         XAn6kZStSgCJWQdPvr1Axl+8YuFFgnyypIX/EuE7NCzeHuaH6vKiaX7yMJZWem9ckXp5
         2M9w==
X-Gm-Message-State: AOAM531JppcxDIzXBgpkswyC/cZPKWZWF9XxRFUpExPNTKYR55IcGYKz
        +BjWmPlqrzdOlfqL5oOqfQ0/KBpTXLrhE4xa
X-Google-Smtp-Source: ABdhPJzdQhYD+xPo2N0v/aeawiojXa1CbWlFTZZ1TjsHko5jmUEIdQu2Rs7qAbj+nQrIf+doGKxoiQ==
X-Received: by 2002:a62:1844:0:b029:152:80d3:8647 with SMTP id 65-20020a6218440000b029015280d38647mr631613pfy.18.1603480511546;
        Fri, 23 Oct 2020 12:15:11 -0700 (PDT)
Received: from ?IPv6:2405:201:9004:6890:ae4b:a0f8:1bbb:ec51? ([2405:201:9004:6890:ae4b:a0f8:1bbb:ec51])
        by smtp.gmail.com with ESMTPSA id t13sm3052594pfc.1.2020.10.23.12.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 12:15:11 -0700 (PDT)
Subject: Re: [PATCH RFC v2] checkpatch: extend attributes check to handle more
 patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20201023094307.20820-1-dwaipayanray1@gmail.com>
 <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
 <CABJPP5Dx4qj-_0gOx0bmaWvJj3okB-tNGJg5-8Y3KF2LnCjowQ@mail.gmail.com>
 <2e8279841d604dde8a3335c092db921007f6744e.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Message-ID: <2a3b90ee-b9bd-2586-9d68-45cbf7e499a9@gmail.com>
Date:   Sat, 24 Oct 2020 00:44:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2e8279841d604dde8a3335c092db921007f6744e.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> And you could check using
>>>
>>>          $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*)/
>>>
>>> and check for all attributes in $1 after
>>> stripping the leading and trailing parens
>>> and any leading and trailing underscores
>>> from each attribute.
>>>
>>> And you only need one hash and you should
>>> check for existence of the key rather than
>>> have multiple lists.
>>>
>>>          if (exists($attributes($attr))) {
>>>
>> Okay thanks!
>> But what should be done for the attributes which are
>> parameterized, like __aligned__(x). Should all the __
>> for these entries be trimmed too?
> yes
>
>> There are also
>> cases where there are multiple versions like:
>>
>> __aligned__
>> __aligned__(x)
> $ git grep __aligned__ | grep -v -P '__aligned__\s*\('
>
> AFAIK: There is only one use of bare __aligned__ and
> that's in compiler_attributes.h
>
>> To help differentiate between them what can be done?
>> Should i make the keys as:
>>
>> aligned
>> aligned__(
>>
>> instead of
>>
>> __aligned__
>> __aligned__(
> Just use aligned
>
> Just fyi:
>
> these are the uses of __attribute__ in the kernel
> with all the underscores and spaces removed so there's
> some value in finding the multiple actual attributes .


Hi,
I modified the check to check the attributes from the map.
There are two checks - one for the normal attributes and
one for the ones with arguments, which needs just a bit more processing.

So attributes like __packed__ as well as those like
__aligned__(x) are handled.

What do you think?

---
+            $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*\)/) {
+            my $attr = trim($1);
+            $attr =~ s/\(\s*_*(.*)\)/$1/;
+            while($attr =~ s/(.*)_$/$1/) {}  # Remove trailing underscores
+
+            my %attr_list = (
+                "alias"            => "__alias",
+                "aligned"        => "__aligned",
+                "always_inline"     => "__always_inline",
+                "assume_aligned"    => "__assume_aligned",
+                "cold"            => "__cold",
+                "const"            => "__const",
+                "copy"            => "__copy",
+                "designated_init"        => "__designated_init",
+                "externally_visible"    => "__visible",
+                "fallthrough"        => "fallthrough",
+                "gnu_inline"        => "__gnu_inline",
+                "malloc"        => "__malloc",
+                "mode"            => "__mode",
+                "no_caller_saved_registers" => 
"__no_caller_saved_registers",
+                "noclone"        => "__noclone",
+                "noinline"        => "noinline",
+                "nonstring"        => "__nonstring",
+                "noreturn"        => "__noreturn",
+                "packed"        => "__packed",
+                "pure"            => "__pure",
+                "used"            => "__used"
+            );
+
+            if (exists($attr_list{$attr})) {
+                my $new = $attr_list{$attr};
+                WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+                     "$new is preffered over 
__attribute__((__${attr}__))\n" . $herecurr);
+            }
+
+            # Check for attributes with parameters, like copy__(symbol)
+            if ($attr =~ /(.*)__(\(.*\))/) {
+                if (exists($attr_list{$1})) {
+                    my $new = $attr_list{$1};
+                    WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
+                         "$new$2 is preffered over 
__attribute__((__${attr}))\n" . $herecurr);
+                }
+            }
---

If this is okay I would like to send in a proper v3.

Thanks,
Dwaipayan.
