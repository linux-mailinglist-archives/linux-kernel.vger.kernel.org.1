Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF02F1E56
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbhAKS4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbhAKS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:56:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A8EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:55:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b5so102050pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GiJzDlHY7NbMJSzu5qvXLENp5Kn/WCh9GwN8prVJoSQ=;
        b=b/R0IYSWidGxFe+KJk08+07xjiNQtQJa0OcNTaPK9ynEWnWFbULEQrVRdKreMoM/YY
         pGR0SWg6b8DUNBAYXKAyF1ML3yhBe5NO7RJJnempYwaNfhJ4h0rBMIDUf4WSa9ss0woy
         7it3v91dpJI/UpJ2275PGTyWNbGNLWBxM9r2fs+Zj7l1phpxYk2J9QQ0UTYlaP3BpqWQ
         ZFmrSuBjN8tgXhf10zKsNEuSRqYOUB3rYmK3TT3KMTp+5DX17JWXVbZefH2EN/GJ/ly6
         d2vZOhOHwqJ+2pOW0edzD9bUWlZNDde/kIzClWRwTQIqSpv2ykEFnUi7BnKM4gGZV+mv
         683w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GiJzDlHY7NbMJSzu5qvXLENp5Kn/WCh9GwN8prVJoSQ=;
        b=H0Kgd9BfxCz2brdOmHRxRhm+o1zjgmKQfiKDPhP2rntseHTghYXQ+rFy6iusvJX6V4
         a2K/SkXE2NRaKkIkRrSKttfCmlgQV6T929xeQBaHOhsxDui2noVLjGyc3uckQzDNd+OM
         s8gn0vq1Mmkl9gBqZF3+eUwdtiolxDJzUMlI24NXxkKTKnrXsDdQQLKuaoP5v4KDeFlX
         pbnAiNe2zgRcPavs2J9MkDlNLWMyqeEFrg/sDI8IXshqHTdUpNa313sBZcWR9AXnWy8T
         rJTxWQ0sJ45QUAvy41jIA4DJ7My/m3AjVzO5rj6xOnAZ4DQEzHG+152QX/BoaXV7i4YG
         vM8A==
X-Gm-Message-State: AOAM533LkFU9gjoQbuUcpBwa8ej2oLDuEfqylp8Q9iQObj94mMcjscEm
        GCvb+R8sAbdcrCefkXtFB2cJzA==
X-Google-Smtp-Source: ABdhPJzK8J8iySjxXueYW+ofTafiBnMREN6lkXERL3ol8gQ+SDjB+djPZQQfslUERvPI+z676VxnbA==
X-Received: by 2002:a17:902:64:b029:da:a9cf:4065 with SMTP id 91-20020a1709020064b02900daa9cf4065mr1156152pla.26.1610391351357;
        Mon, 11 Jan 2021 10:55:51 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 17sm338363pfj.91.2021.01.11.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 10:55:50 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:55:49 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Hyunwook (Wooky) Baek" <baekhw@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <jroedel@suse.de>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V2] x86/sev-es: Fix SEV-ES #VC handler for string port
 IO
In-Reply-To: <1c7f7df6-11f0-e290-cb26-6d8c01b45e2c@amd.com>
Message-ID: <4f71f9a4-3d78-a876-6fab-25549756fd2e@google.com>
References: <20210110071102.2576186-1-baekhw@google.com> <1c7f7df6-11f0-e290-cb26-6d8c01b45e2c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021, Tom Lendacky wrote:

> > Don't assume dest/source buffers are userspace addresses when manually
> > copying data for string I/O or MOVS MMIO, as {get,put}_user() will fail
> > if handed a kernel address and ultimately lead to a kernel panic.
> > 
> > Signed-off-by: Hyunwook (Wooky) Baek <baekhw@google.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > ---
> > 
> > This patch is tested by invoking INSB/OUTSB instructions in kernel space in
> > a
> > SEV-ES-enabled VM. Without the patch, the kernel crashed with the following
> > message:
> >    "SEV-ES: Unsupported exception in #VC instruction emulation - can't
> > continue"
> > With the patch, the instructions successfully read/wrote the string from/to
> > the I/O port.
> 
> Shouldn't this have a Fixes: tag?
> 

Makes sense, I think this should likely be:

Fixes: f980f9c31a92 ("x86/sev-es: Compile early handler code into kernel image")
