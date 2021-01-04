Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1317F2E9EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbhADUcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbhADUcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:32:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84BE12245C;
        Mon,  4 Jan 2021 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609792298;
        bh=8D2TcfjNu1vAY7Hcupcy3ILO+TJDeUSwz62nJSdF59s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dXW3oMotNTGJH0XWaSehUbu8S97Hi6dCOiWaOkOZ0vhnnGBdHkttN7RKStZXssZ5t
         ptS0QxCDJUV8eSd5d6JhQChvbxeZJCc3RQ4Dd5I+mkjJXiVtsXAqFO8d9zLRcmBcAc
         UV6ic4FEhcZr8IlS1EqPRpj38b77HC/l/pKjvh3xTK3jSfxeXh5+vOqpTtNKkwMChB
         g9MPUIZFVPOi5ZbJt9G0Iwwoy0TZcYJuvToPbGhQgmyx+ZRBwdPvjayYmyI9sFvtl7
         DeG61/p27ilsxh64RoD3dzqF2MH7BXUDKiA8vVtuP0Jc3t6DoBGuW5N6DyXhfoMlXE
         u0sxsFLaNYS0w==
Received: by mail-ed1-f43.google.com with SMTP id dk8so28792521edb.1;
        Mon, 04 Jan 2021 12:31:38 -0800 (PST)
X-Gm-Message-State: AOAM5311QXZ8lLXfhGAoBUXKNVr92ATg8TPHGPaWrhASLMkuztQrL2Yz
        ggmjY09JE4n1KNybVmrixRy4gtB7bKZX+XCE9g==
X-Google-Smtp-Source: ABdhPJw/DtnTMlZfg/e7v430OBON7LhidDGoWSo4DCfzLAizx9wQwg1z+WE7uViintBlIVq3z2VyXY8gFN18lSjUZbs=
X-Received: by 2002:a50:e78b:: with SMTP id b11mr71904806edn.165.1609792297081;
 Mon, 04 Jan 2021 12:31:37 -0800 (PST)
MIME-Version: 1.0
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
 <1608717823-18387-7-git-send-email-anshuman.khandual@arm.com>
 <20210103170216.GA4048658@robh.at.kernel.org> <9d19b169-b037-20b1-7c00-b2ba2194addd@arm.com>
 <20210104181549.GB2702940@xps15>
In-Reply-To: <20210104181549.GB2702940@xps15>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 4 Jan 2021 13:31:24 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+oBrfZrJAcg40gScAi2X4XTaskKD=qk+QvacYY=NTr7w@mail.gmail.com>
Message-ID: <CAL_Jsq+oBrfZrJAcg40gScAi2X4XTaskKD=qk+QvacYY=NTr7w@mail.gmail.com>
Subject: Re: [PATCH 06/11] dts: bindings: Document device tree bindings for ETE
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 11:15 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Mon, Jan 04, 2021 at 02:42:08PM +0000, Suzuki K Poulose wrote:
> > Hi Rob,
> >
> > On 1/3/21 5:02 PM, Rob Herring wrote:
> > > On Wed, Dec 23, 2020 at 03:33:38PM +0530, Anshuman Khandual wrote:
> > > > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > >
> > > > Document the device tree bindings for Embedded Trace Extensions.
> > > > ETE can be connected to legacy coresight components and thus
> > > > could optionally contain a connection graph as described by
> > > > the CoreSight bindings.
> > > >
> > > > Cc: devicetree@vger.kernel.org
> > > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > Cc: Mike Leach <mike.leach@linaro.org>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > ---
> > > >   Documentation/devicetree/bindings/arm/ete.txt | 41 +++++++++++++++++++++++++++
> > > >   1 file changed, 41 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/arm/ete.txt
> > >
> > > Bindings are in schema format now, please convert this.
> > >
> >
> > Sure, will do that.
> >
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/ete.txt b/Documentation/devicetree/bindings/arm/ete.txt
> > > > new file mode 100644
> > > > index 0000000..b52b507
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/ete.txt
> > > > @@ -0,0 +1,41 @@
> > > > +Arm Embedded Trace Extensions
> > > > +
> > > > +Arm Embedded Trace Extensions (ETE) is a per CPU trace component that
> > > > +allows tracing the CPU execution. It overlaps with the CoreSight ETMv4
> > > > +architecture and has extended support for future architecture changes.
> > > > +The trace generated by the ETE could be stored via legacy CoreSight
> > > > +components (e.g, TMC-ETR) or other means (e.g, using a per CPU buffer
> > > > +Arm Trace Buffer Extension (TRBE)). Since the ETE can be connected to
> > > > +legacy CoreSight components, a node must be listed per instance, along
> > > > +with any optional connection graph as per the coresight bindings.
> > > > +See bindings/arm/coresight.txt.
> > > > +
> > > > +** ETE Required properties:
> > > > +
> > > > +- compatible : should be one of:
> > > > + "arm,embedded-trace-extensions"
> > > > +
> > > > +- cpu : the CPU phandle this ETE belongs to.
> > >
> > > If this is 1:1 with CPUs, then perhaps it should be a child node of the
> > > CPU nodes.
> >
> > Yes, it is 1:1 with the CPUs. I have tried to keep this aligned with that of
> > "coresight-etm4x". The same driver handles both. The only reason why this
> > was separated from the "coresight.txt" is to describe the new configurations
> > possible (read, TRBE).
>
> Would it be possible to keep the CPU handle rather than moving things under the
> CPU nodes?  ETMv3.x and ETMv4.x are using a handle and as Suzuki points out ETE
> and ETMv4.x are sharing the same driver.  Proceeding differently for the ETE
> would be terribly confusing.

Yeah, no problem.

Rob
