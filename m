Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0729E71C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgJ2JU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgJ2JU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:20:27 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95CB2080C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603963226;
        bh=sq4zrpqihkj72WQb7U9Zm2j4j3kuiJ5BTdpvt1LjO7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tzI/GTy+KrNPawVjjOLRD48StQHPH/7xIIyvtPPQ0RoQaq/KRBg2OU+zbdE3+IHuP
         SNAp5DW2iNt4GzymQnXleBjUdz8nVaIdo3YzokUIXzVW+DWZxydLkCOj7DPVMyqV7P
         9VQYJk1LxA5NwbFOQVAFEVu4MkDDJFTZ6MLxQW1k=
Received: by mail-qk1-f172.google.com with SMTP id p3so1422056qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:20:25 -0700 (PDT)
X-Gm-Message-State: AOAM533Fgq0dryNBmL+4IVZ/bmdPyvhCRWfA6phpkPTiemRr7SdEASu/
        LRwMy4pIGVVLlf0zjCOzYjxnYAJB/YV8ialyOCs=
X-Google-Smtp-Source: ABdhPJzDwRDp7N9ITxc6kjrPs5gnl8PKPQgjJIPH/sMABDAqRlieoXDA3NTMVXAhq+Saal9g/ZyWm0R4RZgqX94MDLo=
X-Received: by 2002:a05:620a:215d:: with SMTP id m29mr2736869qkm.138.1603963224989;
 Thu, 29 Oct 2020 02:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201022050638.29641-1-sherry.sun@nxp.com> <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org> <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com> <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com> <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
 <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
 <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com> <VI1PR04MB4960F02E95A908D3D1DBE0FE92140@VI1PR04MB4960.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4960F02E95A908D3D1DBE0FE92140@VI1PR04MB4960.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 29 Oct 2020 10:20:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0j234Phsc84wRBNx7wd8UJt0tGVD+kXj0izQp6ZEx2ew@mail.gmail.com>
Message-ID: <CAK8P3a0j234Phsc84wRBNx7wd8UJt0tGVD+kXj0izQp6ZEx2ew@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used ring
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 3:42 AM Sherry Sun <sherry.sun@nxp.com> wrote:
> > Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used ring
>
> Thanks for your detailed reply.
> Yes, the PCIe endpoint subsystem is the base code, actually we have implemented a set
> of pci endpoint code similar to pci-epf-test.c, combine with vop (Virtio Over PCIe).
>
> But now the vop code is going to be removed, we planned to change to NTB framework,
> I saw Kishon has done some jobs based on NTB and PCIe endpoint subsystem, will get
> a deep look. Maybe it is a good solution.

Ok, great. Regarding the VoP code, I think nothing stops you from reusing
anything you find useful in there and build on top of it, but we should
consider it as a new submission then, which means that you are free to
change the interfaces without worrying about backwards compatibility.

On the flip side, this also means we need to carefully review the interface
to make sure we can cover the requirements of as many users as possible
without adding too much complexity for cases that we do not care about.

      Arnd
