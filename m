Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCB92E0F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgLVUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgLVUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:18:34 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CEC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:17:54 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p187so13123083iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zLJLP7tCAUwtOH7bnIcDYFQtzmD3kgV+pxzg546b1k=;
        b=XC6Br8D+89r1c0JcPMrO3nO6KaRrr8ocyrLF47pEfYQUJe3E1u/P6NZigHGMMumbIK
         HCdQ77TvBkYou2+v7emwbJdr7rc4fVDh2qnGN/1YRKfbuGAcnhh3b9sBd3fOg/TW/8B5
         k1YCh2Gzk/m/wddzgZnfSjui9OSQhIdclFkY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zLJLP7tCAUwtOH7bnIcDYFQtzmD3kgV+pxzg546b1k=;
        b=TLYDJcKMnl0BC4PdV7lOvs0A97CdYzWFViEEBOYnMoLkNctNcXLEp1k0SokWi1cHeX
         usDCB/Px+mebAsMcY4mDyI672WR0Yb6vh0Z2XK3XxGEkuWaFRBYJMbkSuk4RCBiyx7QS
         1myZBaHVwqFlF6cjmqjxmuEwutDonl7sOfhhbveB4fNw0GwmnErk87C86N4bTviHzfqy
         uDXe9/WdHRXF4zg81P4ZK2xRL3ln8SJa1Me/6iOqD0KmCISM6Hi/aKojptBGA44ZGWmW
         LY4MljsgLaR/fkZAQX4euKHpyXHMs3Qty8DuE2BAlDkYCGRecygAfXRRc7OIK0MyKctI
         i+eA==
X-Gm-Message-State: AOAM532TdqWBvzOD+IB5qcK+51T5VWOPsUEIVoaHA+E9CHuehko8jMCt
        EItK+lsqYJXqapmGldyJF+pviWx/UOEr2P+G+bZDBA==
X-Google-Smtp-Source: ABdhPJxodNAzCORMWfMCbsvvW5DAgOp02Nbq+NPpU5r0VLJ57U4m1OtSsaDEzp4qiIHerc0HSaKfUi6EmT4jhIFkZU8=
X-Received: by 2002:a6b:8b88:: with SMTP id n130mr19051497iod.122.1608668273230;
 Tue, 22 Dec 2020 12:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com> <20201222141818.GA17056@infradead.org>
In-Reply-To: <20201222141818.GA17056@infradead.org>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 22 Dec 2020 21:17:41 +0100
Message-ID: <CABRcYmKBgQYHezKVaLCVwUvksFaVuU7RHW8VVjM6auOC_GOr+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 3:18 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> FYI, there is a reason why kallsyms_lookup is not exported any more.
> I don't think adding that back through a backdoor is a good idea.

Did you maybe mean kallsyms_lookup_name (the one that looks an address
up based on a symbol name) ? It used to be exported but isn't anymore
indeed.
However, this is not what we're trying to do. As far as I can tell,
kallsyms_lookup (the one that looks a symbol name up based on an
address) has never been exported but its close cousins sprint_symbol
and sprint_symbol_no_offset (which only call kallsyms_lookup and
pretty print the result) are still exported, they are also used by
vsprintf. Is this an issue ?
