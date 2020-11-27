Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717F92C61A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgK0JZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgK0JZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:25:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281DC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:25:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so4812191wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2toaXqO7eAxS52tJyQVRw0+GDwnYT0VbxjWaMoFUCXs=;
        b=H6+N6X01Vadj6yEz/vyTZBJlPFNeSeyTwZbp25I+jgznlUMLg+Uv1tt2hXhU0Gsjcm
         yDeSNT0BFQlnZ5LqTSU2Yk9nEHqzFOj6y5x/8R3ueWj/Vg8VJAxME/4p6Lol6T8X89t5
         e2vN6Veae25EE3DAlBLexYGP8moLKXbm0+mSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2toaXqO7eAxS52tJyQVRw0+GDwnYT0VbxjWaMoFUCXs=;
        b=o4kkkJflA1Rbzqo9T4QbqvArXM94dNFLfCOhVseY8R6aXm6Hz9XUuQiIWfWG1G+kVg
         wwM/uIqZpGOKv2tKtxlGMCaMsQyYsmBe/bsnLLok1Se6+0kHXrRQ+YbzUHfcmSZhyehO
         YhOJvxYBJlyxe2ZrzRgznv4thH5KzNqALUiVkGWGii8NK9fHA616WwwM5T5R1vwamhkN
         DMG7M++DThcMAd+7iar8S2UAv/1a8j7p/aKrYWIpbBu/AL/QaLzojOC8t21h3Rj/Uwmz
         eayNTCRYKX9TP7U46yTYVxbcz9oAzvlhBMdzM/nBephn1W+jUMjRSh2QxeBO6Xhc5UI1
         KS6w==
X-Gm-Message-State: AOAM532a+OTxR1d2pf6/VwZwA1xks8Qvx5ywdCBY2BMqKE5corRwfida
        d2s7xv0kC3zGOhraCMo0lv3vXA==
X-Google-Smtp-Source: ABdhPJzKxL8zJc8mDyenBRdO0D0lm7//PnKEqdv6S4iFuZ/vETNkOE1vuLBYTiDqbg7s7RP0pNyKUw==
X-Received: by 2002:adf:f181:: with SMTP id h1mr9071711wro.267.1606469110310;
        Fri, 27 Nov 2020 01:25:10 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id v7sm6326100wma.26.2020.11.27.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:25:09 -0800 (PST)
Message-ID: <c5af620d027aba9c3cdf2d642c3611f908638a3c.camel@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
From:   Florent Revest <revest@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 27 Nov 2020 10:25:08 +0100
In-Reply-To: <CACYkzJ65P5fxW1bxVXm_ehLLE=gn6nuR+UVxYWjqSJfXoZd+8g@mail.gmail.com>
References: <20201126165748.1748417-1-revest@google.com>
         <CACYkzJ65P5fxW1bxVXm_ehLLE=gn6nuR+UVxYWjqSJfXoZd+8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-27 at 03:32 +0100, KP Singh wrote:
> > +       ret = strlen(name) + 1;
> > +       if (symbol_size) {
> > +               strncpy(symbol, name, symbol_size);
> > +               symbol[symbol_size - 1] = '\0';
> > +       }
> > +
> > +       if (modname && module_size) {
> > +               strncpy(module, modname, module_size);
> 
> The return value does not seem to be impacted by the truncation of
> the module name, I wonder if it is better to just use a single
> buffer.
> 
> For example, the proc kallsyms shows symbols as:
> 
> <symbol_name> [module_name]
> 
> https://github.com/torvalds/linux/blob/master/kernel/kallsyms.c#L648
> 
> The square brackets do seem to be a waste here, so maybe we could use
> a single character as a separator?

I prefer Yongonhong's suggestion of having two helpers. This gives more
control to the BPF program. For example, they could decide to audit
only addresses coming from a module, and that would be easier to do
with two helpers than by parsing a string in BPF.

