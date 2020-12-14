Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF982D9F45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440903AbgLNSeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:34:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33583 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440895AbgLNSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:33:55 -0500
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kosem-0007v5-13
        for linux-kernel@vger.kernel.org; Mon, 14 Dec 2020 18:33:12 +0000
Received: by mail-ej1-f72.google.com with SMTP id a8so4851972ejc.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vC5rTts+mOzcrtivhr5wMtWrTwvDKun97Izjg1g5DwM=;
        b=fmDHYPwJW82aHXOJyDDLHpXlG3ZBSbI6pTRAkeqUuezfVdTIuDhM+E7rncCXweEloS
         AhB2ejsUl8gTrII6pjJeP7oLWxiGdYLMN5pLJCc8L6qLuGbiINpfilq62CtqnUwSp/rt
         1Rf80nd/Otl0qZh/PH5Q1/m++CWXrTWlmrKQrzyITaBx8DsQ+Z5tG9c/nzBQZDgyEvQr
         VLUXESCCcbkBt0xSeenaxjjNj+xjRRTVI8WgyF9g9W/fNL5IV9OI+jcC1ELd5+LSt1Rz
         IGii4FVPFeESlArvzck7Ce2Ynof0etL5fpydob+nkQM58N8i6XKSzKqZyQw9UqtD//xI
         nPCQ==
X-Gm-Message-State: AOAM530ltjr+2OyX/K8eOZ3nogvjyQQkuO5/oMPVZyGYDfaXGewqT3eF
        OTqpyFQac/V5+yVfXcq63ovbyeyBob6UpOvBv9zIjLcGhhO2VS8miCfu564crmlVkKPcUiIE7V2
        nl+u3QQuYPC1CYDvbqGabk4eDcKV2SikpDmREkOI1S81hpiYJF0ikcs/odg==
X-Received: by 2002:a50:ed04:: with SMTP id j4mr26821208eds.84.1607970791740;
        Mon, 14 Dec 2020 10:33:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKhS9zZJoH5y+WjTKhFM+13gIWs9+51ExLKCSPqVyqui+xXMHuPFwo81j9PBZsvzg/q2ofOvchb4pAtUadEkg=
X-Received: by 2002:a50:ed04:: with SMTP id j4mr26821177eds.84.1607970791542;
 Mon, 14 Dec 2020 10:33:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHD1Q_yfFYrfAEHTA3mW25hK9DFFYnKQ2_1HCEnL4m=bc=rLfg@mail.gmail.com>
 <20201130202021.GA1106292@bjorn-Precision-5520>
In-Reply-To: <20201130202021.GA1106292@bjorn-Precision-5520>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 14 Dec 2020 15:32:35 -0300
Message-ID: <CAHD1Q_zKmQawrOQrR3DM0nnBF06nO=L_PcMEQMBvZA6xKMxtWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the clarification Bjorn! I was on vacation..sorry for my delay.

Closing the loop here, I understand we're not getting this patch
merged (due to its restriction to domain 0) and there was a suggestion
in the thread of trying to block MSIs from the IOMMU init code (which
also have the restriction of only working in iommu-enabled systems).
Hope the thread is helpful and if somebody faces this issue, can
comment here and at least find this approach, maybe test the patch.

Thanks to all involved!
