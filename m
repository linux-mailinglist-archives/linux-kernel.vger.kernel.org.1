Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621F5233A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 23:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgG3VPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgG3VO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:14:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275EDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:14:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f24so8891642ejx.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQQ6RdOfI3qK/AtcGyAa3PPfsZ6PvAzcNLL/uW5Ov+c=;
        b=iSeinaQFf3yOe2lHxw0CJ8uvvymodnA+gZRBuK4XFslunfBv0lKOpua4/qzmJAeEFf
         CIhT9MTlKcx429Yqx/9BIvA0klhKjSnvGk84//qFwlrkB9ss82m9nN1DLOaLaapcrVBh
         KwI/PLMaPPLuiVBdfpgbc6+Q6yzAILIrEWmSOzbfKHx359OcZL2Ra3+hiznU8ilKAdgG
         YM3x9kcYKXXxov8pSZBJMUeEQ2qZIy648K1J3KfS1xgw1u2pwO3Wr8gjFMa+X2vSEiZ+
         yNar+F+DxEXNUGQoQlvdbdB6KQ/xGNWe7kHQq4J3/QP3sB0jL/wbrhD+H/8BX/pHIxDw
         xrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQQ6RdOfI3qK/AtcGyAa3PPfsZ6PvAzcNLL/uW5Ov+c=;
        b=L+yOEkNzqe5jEuGcYvDAO7ZTclrxMVpeL/uqyB8PTkYiK1dPkaTKy19SnpiOprcc6e
         qDcOXOzinZnep2Z07ZFrssRUF/ZcgkOEe8oVUHgqTwhF0Z189Jst9qwrEWtrmZuNUP5N
         6jK5Qrbx0Xq5pIqV6e2tqnbnzr0yT82Td19Z6YzaXtM8b1+oKDslvI7qC6zQvvvNe5no
         O7opbxrptj7ONvNyYmTpexHsAalk8DTo9x41dtka5iRpIbqI1IFLsAovMpCR4yer+Y5s
         oOvib1xu0qCxAEHHogzI/9HYdZTTfE+9aKDZJESpOrvFxXYv1gwCIEG643FuC631eOJm
         OImw==
X-Gm-Message-State: AOAM5300i/4leF9iscWE785/xfPw94Jk9tzyBsiF/v1Pc/6mpxCsZ5C0
        /YKcwwSdPV3Blv5JOwwcTfq3aA==
X-Google-Smtp-Source: ABdhPJzlHh02QVVAFLKTB+xoRHb3mqAraUbK6zYudTHxIdHXY8kSsZkO1Rf8FHPFvQ+mk1u0vH6A8A==
X-Received: by 2002:a17:906:fb07:: with SMTP id lz7mr991136ejb.49.1596143697686;
        Thu, 30 Jul 2020 14:14:57 -0700 (PDT)
Received: from lophozonia ([2001:1715:4e26:a7e0:f1b0:45a6:cd09:bcd0])
        by smtp.gmail.com with ESMTPSA id w20sm7569128eds.21.2020.07.30.14.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 14:14:57 -0700 (PDT)
Date:   Thu, 30 Jul 2020 23:14:53 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Qian Cai <cai@lca.pw>, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, songliubraving@fb.com, andriin@fb.com,
        catalin.marinas@arm.com, john.fastabend@gmail.com, ast@kernel.org,
        zlim.lnx@gmail.com, kpsingh@chromium.org, yhs@fb.com,
        will@kernel.org, kafai@fb.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
Message-ID: <20200730211453.GA79372@lophozonia>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <20200728152122.1292756-2-jean-philippe@linaro.org>
 <20200730122855.GA3773@lca.pw>
 <20200730142213.GB1529030@myrica>
 <f2f05f41-ccf9-e693-85bf-59ebbf8dadfe@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f05f41-ccf9-e693-85bf-59ebbf8dadfe@iogearbox.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:47:39PM +0200, Daniel Borkmann wrote:
> On 7/30/20 4:22 PM, Jean-Philippe Brucker wrote:
> > On Thu, Jul 30, 2020 at 08:28:56AM -0400, Qian Cai wrote:
> > > On Tue, Jul 28, 2020 at 05:21:26PM +0200, Jean-Philippe Brucker wrote:
> > > > When a tracing BPF program attempts to read memory without using the
> > > > bpf_probe_read() helper, the verifier marks the load instruction with
> > > > the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
> > > > this flag it falls back to the interpreter.
> > > > 
> > > > Add support for BPF_PROBE_MEM, by appending an exception table to the
> > > > BPF program. If the load instruction causes a data abort, the fixup
> > > > infrastructure finds the exception table and fixes up the fault, by
> > > > clearing the destination register and jumping over the faulting
> > > > instruction.
> > > > 
> > > > To keep the compact exception table entry format, inspect the pc in
> > > > fixup_exception(). A more generic solution would add a "handler" field
> > > > to the table entry, like on x86 and s390.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > 
> > > This will fail to compile on arm64,
> > > 
> > > https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config
> > > 
> > > arch/arm64/mm/extable.o: In function `fixup_exception':
> > > arch/arm64/mm/extable.c:19: undefined reference to `arm64_bpf_fixup_exception'
> > 
> > Thanks for the report, I attached a fix. Daniel, can I squash it and
> > resend as v2 or is it too late?
> 
> If you want I can squash your attached snippet into the original patch of
> yours. If you want to send a v2 that is fine as well of course. Let me know.

Yes please squash it into the original patch, sorry for the mess

Thanks,
Jean
