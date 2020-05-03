Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25601C2DCA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgECP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:56:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43269 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgECP4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:56:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id g14so6733116otg.10;
        Sun, 03 May 2020 08:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WYg40TLk3KADJiyif1yUUKuz9+nrJ8NqElcSmLLhB0k=;
        b=M3O7PrgQJna/jDlOFKLh8Cm7iQGjo3mdjx7U+X4UUmJmohWo5vsR96p17pwQJy45kY
         JI/9mB5qnKFCbPmv1dXhhs8g/g7jEP3Jnhmax8EMlKUZazLv06OSzvb8Tg2jT8SbaxOv
         8T5GAf3pH6IOK6o9H6iZ9MGwLm+cJ9BOJ8X3irok3Lb5zJpye5RIaP5P2pu9MvGjTtxw
         FH9xML8DlzEN795xXzplqIqvGBFslNSLNMq9vLgFCm4Bs+s3ADRgKfd98LfD/3NLaf9P
         JIYseapgbo/VFouNP7l9NWr4qzNM3sy/pP30ZLC+h6JxrAXy9w1oxzQu4iscGCmbkiNZ
         JuqQ==
X-Gm-Message-State: AGi0PuYDjFJeo6oMpvPnLpWkG0x+moVlIdeDSK3N76yj+PcZDEqX9KL4
        hTYNm476W6vEz8SBOB74vw==
X-Google-Smtp-Source: APiQypIaJB2V1R3yN4okOSQIUQdfXjuVW2kXux3Do0/BFcV5FP8EpdLt2iu8wdRoFonVOD7wWRvOpA==
X-Received: by 2002:a9d:3988:: with SMTP id y8mr10608108otb.352.1588521379608;
        Sun, 03 May 2020 08:56:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y131sm1651023oie.39.2020.05.03.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:56:19 -0700 (PDT)
Received: (nullmailer pid 22470 invoked by uid 1000);
        Sun, 03 May 2020 15:56:18 -0000
Date:   Sun, 3 May 2020 10:56:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH v3 7/8] dt-bindings: ipmi: Convert IPMI-SMIC bindings to
 json-schema
Message-ID: <20200503155618.GA22437@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-8-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-8-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:53 +0100, Andre Przywara wrote:
> Convert the generic IPMI controller bindings to DT schema format
> using json-schema.
> 
> The device_type property is deprecated for most node per the DT spec,
> but at least the Linux driver matches on it, so I keep it in.
> 
> The Linux driver parses for some additional and optional properties,
> but there are no in-tree users. Let's allow extra properties to cover
> any other users.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmi-smic.txt    | 25 --------
>  .../devicetree/bindings/ipmi/ipmi-smic.yaml   | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
> 

Applied, thanks.

Rob
