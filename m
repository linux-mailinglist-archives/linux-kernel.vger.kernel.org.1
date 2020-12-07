Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34D2D19F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLGTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:44:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8EFC0617B0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:44:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bo9so21135898ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+ne0GIKqTiBoOHj/8BINlg1y+EHZi6FtbaG0qha9YKQ=;
        b=XMDhzv28iCECmyEscX+hfMAVVuWQzHZp21Zavjrcx4by2MNxNKPEGVN4xig6SqXmD6
         behzcE5w4VrBRU0Bm3KXkqIfRxMOGuZjmbXccGzOVMD+cmAwfmrOMV/8+7wBxpdibUdg
         azgPkB+oLeBs715NusjgSL+qzg4fnFZVxH9Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+ne0GIKqTiBoOHj/8BINlg1y+EHZi6FtbaG0qha9YKQ=;
        b=QInPo+QsKkgrfi7M7n+IJzJq7OQd0rEvzuOQBYmW8ifeMhT08La42tC8rTPIKgU+03
         Xu5ieaI+JioyNlNXlJLk50Vg+FGZC4UXWLjEHtjBttDiuR/J7GmIlTtvtQoiYDQfoEMe
         gw2ihW7fvR41WraWpyiDBTx3v3EPnmppvbXvJ+tho3hSca/CAwOPut7ES40A8ksxTBYr
         SPhnAa+xYQBLY20Gf254vmbUZQMiz6xlv/MnQAAVp2ABNEk6Q6iSAXk1BBhjMm57feFi
         GDlEDUgBpmZdvepmXQmZWwSmn0btqu23E8TGV3qK0c3ejVTsZnTSeJsg8+CQYBjUnsPK
         Lcsw==
X-Gm-Message-State: AOAM533GHg4lmTzs1zRbKFnnZQSntBhhZjB4V8cghAMhUj7T0sjVc8vI
        3Lan6RdGmI94GcFrLZZl2dLb8R+gelHdUQ==
X-Google-Smtp-Source: ABdhPJzAqqtK5ms3jsKRJ7blt5YhUU/Pinq3V4LDDazyb22nUxTY2Foq5JSyPO8x0h93y+xc2Yqnew==
X-Received: by 2002:a17:906:c408:: with SMTP id u8mr20213768ejz.364.1607370243525;
        Mon, 07 Dec 2020 11:44:03 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id cc8sm14275838edb.17.2020.12.07.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:44:02 -0800 (PST)
Message-ID: <bc37337ff82e187e39d029ee9f488d81e2b4fb44.camel@chromium.org>
Subject: Re: linux-next: Tree for Dec 7 (bpf: sock_from_file)
From:   Florent Revest <revest@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@google.com>, bpf <bpf@vger.kernel.org>
Date:   Mon, 07 Dec 2020 20:44:01 +0100
In-Reply-To: <b8f2e76b-a35e-55c5-e937-eea81700c994@infradead.org>
References: <20201207202520.3ced306c@canb.auug.org.au>
         <b8f2e76b-a35e-55c5-e937-eea81700c994@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-07 at 10:39 -0800, Randy Dunlap wrote:
> On 12/7/20 1:25 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20201204:
> > 
> 
> on i386:
> # CONFIG_NET is not set
> 
> ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
> bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> 

Thanks Randy! I'm on it, I'll send a fix to bpf-next.

