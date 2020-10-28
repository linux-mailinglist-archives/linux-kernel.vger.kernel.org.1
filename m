Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6479C29DA64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbgJ1XVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgJ1XT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:19:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:19:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d24so1039268ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bddUYsH0Q4taj7eCHyEIuGJKg/yr7YiUZPcQWZ6v1LE=;
        b=CHOjYBk8HiC/jeqJz46qiJ+eYkb+cO4QM0ST57G8Nj2qaYtoA0bq4KHBXJtXjg+qn+
         qekfDBVppaQE4Yyke5X5qlxyMuhkAbtoBNmRWxYK34Vrwe3eM4wSayOsyRBkjvzCNUUv
         HMCWEwEVOMezfYxCSLc7scukjloUxce/3BAD2DjJ/WYsKofME5qrQK+vJqTQ1TsAtLFw
         lNAnvVGC40++z0+IzngjlpSCAVdy2FYHPPrLqZbaVs2MH3WVU416Yz/AiNmPgRrQ6RjX
         MSX4iUdP+tds4JwsZst/RWETtsd+DLjwE26Rp3d3tbLnZ5YsEy1G3RHY9AyfoPwGky8q
         9ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bddUYsH0Q4taj7eCHyEIuGJKg/yr7YiUZPcQWZ6v1LE=;
        b=GueGvXMMHnMVgKXktHy7i0u9pZCTuQkNkkzFMKDiV0oVM5K9lS7uuzicboP/y7cg1A
         aXX08CW8jkEcC8DTmsNpTuNhdDL381JWocyRZn0+p8dCY3gMDw9pMEO8j6qwngO3dLp8
         RCbf1PJEm1yxtlmAXr171/xKWodMLoBMKmGL7YsfI+XejUMYb2EiV5Nc/F+jbSCS95Pr
         sga68q84chGIy4LBzzTGLgMnAEyOf/kQTBf9fEnu7CXHb1hjTtSAO4LG9CfehPrONe25
         wKsCCnhWdnSaJ+5H7ntOLMCzQTLkzD4Z8q14NJq0cdtrbRyY447P5TEC9/6iCMoj/Te8
         HrHQ==
X-Gm-Message-State: AOAM5336ppA5/O8FuY1vg5Lyw8GsPU7TYl3IALgEliHIG8JnK7hVgo//
        aWUrX6q7WBWBXNHpNGOitugOEzsAqHyPVf60YmHz0g==
X-Google-Smtp-Source: ABdhPJzCs+C7nGVmskqV5HWtwP2HsoDUyoZPtmjPyl0kVxXWNVUEZaqXQZSqJhoXzMmq2aFQ+100yvJkxcOjHt+nb5g=
X-Received: by 2002:a2e:8845:: with SMTP id z5mr648833ljj.216.1603927193515;
 Wed, 28 Oct 2020 16:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201028231545.4116866-1-rajatja@google.com>
In-Reply-To: <20201028231545.4116866-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 28 Oct 2020 16:19:17 -0700
Message-ID: <CACK8Z6HHP7O96zAHW4MM6ZtH-6h1WcJ=VtAVCXbGnRL3400SLA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Always call pci_enable_acs() regardless of pdev->acs_cap
To:     linux-pci <linux-pci@vger.kernel.org>,
        "Boris V." <borisvk@bstnet.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-random email address (typo)
