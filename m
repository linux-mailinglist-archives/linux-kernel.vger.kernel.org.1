Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC72B1EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKMPjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgKMPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605281962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sVmrN/C/Kv+IDV0OFYnceQhXDUD+b2Eui7WOb+LnZE=;
        b=PyKtSpsBar4JwMa36iiUZo4P36nPAxnD8RCHFi2RMNSYWz1dzVJ+a2+AxizSBvfwny5Adq
        eIrkDeiAizi8WHAQjGwPFUFcETrZ87GDrJLI8L8f4m04Qza7/YqGtpIkN14Yz2wWgngLMj
        FfSY+NKeQ4+C7K8BdgRYPD2C+y4mkaQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-4nMi6yisNC-7DxW2If78gw-1; Fri, 13 Nov 2020 10:39:20 -0500
X-MC-Unique: 4nMi6yisNC-7DxW2If78gw-1
Received: by mail-wr1-f70.google.com with SMTP id h11so4021278wrq.20
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3sVmrN/C/Kv+IDV0OFYnceQhXDUD+b2Eui7WOb+LnZE=;
        b=LxGzY+FwhCXkfuvogQ/IXdqSkPtse1OBXf4pCKsH2l9oSo2mcxtXCg/xlBdgfTmv9b
         q4oT3/Xl6Z321q1H2dxWInkA1fRHfPk4jRVSME30JCu0+8mdMTfWiDzl5bJK9Ccs9Byi
         E7AjamkdB8wXk5jSn91/FWRtepXWOdbY/JytQ6scy/GnmgbnZGpTMhKGz62XSWRbtxxb
         6S8LwVtaak2ClTpOuyVKY5AyMur7OsW8DbwThFDuPiM9gndpb18WDlU7oyBcVeuPiY8/
         EmYJJgFenkTJXmxZa6630mkqddIfcxcHzqeld8e6Kp3aurHk6gHWOXQbiN79IahUks1J
         JUEA==
X-Gm-Message-State: AOAM530IbuSO5jz7GoaUzTQlZUdY+vXjF+l5woA6Jb1ZRZncmzpwpzKO
        FGjtfYcyCvAaLJcYko2NuOozz4E13P9pc6spwU3Zvdpzh8bZxwzT0AHa/l2y2wBS2pFkZ1oglH/
        F1swSTDvgF1y2lWzvJSrMHZO/GrSTsaspyjszLbszy3YIVzAG5gF/cKrPjnDd/zdbk9T4t9k7MB
        74
X-Received: by 2002:a05:600c:2285:: with SMTP id 5mr3140835wmf.149.1605281954368;
        Fri, 13 Nov 2020 07:39:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7rJrV3ihlOr4+/s5jLfPJiFT3LF4QQ9loxw6d7jCck5tzg9yvmEn8xNaai16p+3MSbkOfFg==
X-Received: by 2002:a05:600c:2285:: with SMTP id 5mr3140483wmf.149.1605281949385;
        Fri, 13 Nov 2020 07:39:09 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b73sm17842334wmb.0.2020.11.13.07.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:39:08 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed/64: Drop the now-unused
 finalize_identity_maps()
In-Reply-To: <20201113151342.GA618063@rani.riverdale.lan>
References: <20201113150810.1233016-1-vkuznets@redhat.com>
 <20201113151342.GA618063@rani.riverdale.lan>
Date:   Fri, 13 Nov 2020 16:39:07 +0100
Message-ID: <87361dw9k4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Sankar <nivedita@alum.mit.edu> writes:

> On Fri, Nov 13, 2020 at 04:08:10PM +0100, Vitaly Kuznetsov wrote:
>> Since commit 8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in
>> KASLR code") finalize_identity_maps() has no users, drop it.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/boot/compressed/ident_map_64.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>> 
>> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
>> index a5e5db6ada3c..6bf20223dc0f 100644
>> --- a/arch/x86/boot/compressed/ident_map_64.c
>> +++ b/arch/x86/boot/compressed/ident_map_64.c
>> @@ -167,16 +167,6 @@ void initialize_identity_maps(void *rmode)
>>  	write_cr3(top_level_pgt);
>>  }
>>  
>> -/*
>> - * This switches the page tables to the new level4 that has been built
>> - * via calls to add_identity_map() above. If booted via startup_32(),
>> - * this is effectively a no-op.
>> - */
>> -void finalize_identity_maps(void)
>> -{
>> -	write_cr3(top_level_pgt);
>> -}
>> -
>>  static pte_t *split_large_pmd(struct x86_mapping_info *info,
>>  			      pmd_t *pmdp, unsigned long __address)
>>  {
>> -- 
>> 2.26.2
>> 
>
> I had sent this and another unused removal last month:
> https://lore.kernel.org/lkml/20201005151208.2212886-1-nivedita@alum.mit.edu/
>

Ah, no problem, let this serve as a gentle ping to the maintainers then)

-- 
Vitaly

