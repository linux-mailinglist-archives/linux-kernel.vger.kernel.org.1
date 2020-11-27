Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113D32C6184
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgK0JU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgK0JU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:20:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB152C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:20:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so4832669wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rJpaqMmbVzz+/0uX+e9OASza/Sn3/crC+q1r7cTKszU=;
        b=SzZ4g5EZyvlo/1WuSpEOEZ+lT/uj0/nD+7fbnLbOCukSu5cPvbndOrOgQmTskZUi9i
         L6XoTJTbI9ePX5hhNoGaCa3Fzy+xrZCqx45naO/ZTANRygTOwjjYMVPjAKIP69BQpwHE
         I8sqEf+EkI40NHTUPiimW43keAelqcer7FevI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rJpaqMmbVzz+/0uX+e9OASza/Sn3/crC+q1r7cTKszU=;
        b=m8Wz6BK8ufKD7/djV3WnzbLktwfZeYLkeKpO6Zy42mYR9BnTE8Zl4IyA+i1aDQ5KrD
         7RiLPmRIx0jUhr9R2u4o0EzZ6fGK4/ZwXDlsYBUZcodA+8EmWqL7tUtyNpvdkVuu1olQ
         cFBhbeVz4Jn/ydxruyGkvhw2ZWv0ln8Q6w+f7oyG9NFIngimeZJU85lHhdqtGITZ9Zdz
         uRh/3Pd2Af1/vceAGh18oMEpCXNVvsV6LaQrFCl0dAlcKqSHY9BvDg1Yn+fu4TJCm+5q
         mnmsy9Qvj0PM5yu5AK4J19C4AGejtXhjz64K++Q3sEaZ/A1rYeOTc27dHcYbvRr6jPPi
         7NNQ==
X-Gm-Message-State: AOAM532i6rs8H0fxZemfQAagQXUlPqUTA82hFUDuw6VJkEQTBYvVoj7o
        pd5Fx6n2uT2eq1pVoaOJVf+NKQ==
X-Google-Smtp-Source: ABdhPJx9AJrAO859wmrt5XgU3NFYEMmYexm61rQy05tUL65QlEC16hmuUT4HMlWjmMAaARuPripL4w==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr9098029wrm.141.1606468855682;
        Fri, 27 Nov 2020 01:20:55 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id g11sm14320442wrq.7.2020.11.27.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:20:55 -0800 (PST)
Message-ID: <b7e6aa907d62a36dc86e54691463ed699f22a4cb.camel@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
From:   Florent Revest <revest@chromium.org>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Nov 2020 10:20:54 +0100
In-Reply-To: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
References: <20201126165748.1748417-1-revest@google.com>
         <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-26 at 23:35 -0800, Yonghong Song wrote:
> On 11/26/20 8:57 AM, Florent Revest wrote:
> > +BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32,
> > symbol_size,
> > +	   char *, module, u32, module_size)
> > +{
> > +	char buffer[KSYM_SYMBOL_LEN];
> > +	unsigned long offset, size;
> > +	const char *name;
> > +	char *modname;
> > +	long ret;
> > +
> > +	name = kallsyms_lookup(address, &size, &offset, &modname,
> > buffer);
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	ret = strlen(name) + 1;
> > +	if (symbol_size) {
> > +		strncpy(symbol, name, symbol_size);
> > +		symbol[symbol_size - 1] = '\0';
> > +	}
> > +
> > +	if (modname && module_size) {
> > +		strncpy(module, modname, module_size);
> > +		module[module_size - 1] = '\0';
> 
> In this case, module name may be truncated and user did not get any
> indication from return value. In the helper description, it is
> mentioned that module name currently is most 64 bytes. But from UAPI
> perspective, it may be still good to return something to let user
> know the name is truncated.
> 
> I do not know what is the best way to do this. One suggestion is
> to break it into two helpers, one for symbol name and another
> for module name. What is the use cases people want to get both
> symbol name and module name and is it common?

Fair, I can split this into two helpers :) The lookup would be done
twice but I don't think that's a big deal.

