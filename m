Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23032DF9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgLUH4x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Dec 2020 02:56:53 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37398 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgLUH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:56:52 -0500
Received: by mail-wm1-f43.google.com with SMTP id q75so10021627wme.2;
        Sun, 20 Dec 2020 23:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IZitIFlnmtD/PO5Bk34PbB1x1heRpMsN4+voHWPHlpA=;
        b=HFTXOMOynIha6BBImFRKN/SNpdBZ39r5s9q+Y/8URiSkxQ766FRnHmzlQJNsuBt3TE
         cRWo2h3Gb7/pCsOTsIta1+Hzk87pGzboLUf0H6qlwBbiGI7M7+OGq5PCDH/V0Vm/J4hy
         Eib5ycbypAlAQ2X/lOVF6JrbWuqifYvV1BUqSip6VTX5ydH5bQpCJ0dPuPYrLxpOjisi
         cdIqX3njfzJoKDY8Qe3vp6wgYUk+UIqqLG9jPr0zEghMn2JoLWzTExexmtDnESqzGgRB
         Pt9S9m9aVGASZhycWcdsEFoCFxsU75oraWv0vF2uipfB7HYpAebRG1CRgs/4s0CECeee
         NyuA==
X-Gm-Message-State: AOAM5307qdNCT6yglexqRl3H3q7ILV4k5GN5WAptoVF/VoaNrJqb9ciT
        M6128/b/iEnP9I9yyJoAJZA=
X-Google-Smtp-Source: ABdhPJxSbsQTInETAB2FkKIVe2Wtk/wsibniVXFrCgz90c+UdyaXSTMwiIi3gvc1lDyrW/LGI02ZzA==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr15154043wmj.170.1608537370489;
        Sun, 20 Dec 2020 23:56:10 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b9sm23706221wmd.32.2020.12.20.23.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:56:09 -0800 (PST)
Date:   Mon, 21 Dec 2020 08:56:08 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: imx8m: add NVMEM provider and
 consumer to read soc unique ID
Message-ID: <20201221075608.GB3386@kozik-lap>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218083726.16427-3-alice.guo@oss.nxp.com>
 <20201219121656.GA13886@kozik-lap>
 <AM6PR04MB605316DAE14009BB28804AB3E2C00@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB605316DAE14009BB28804AB3E2C00@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 03:10:52AM +0000, Alice Guo (OSS) wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年12月19日 20:17
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v8 3/4] arm64: dts: imx8m: add NVMEM provider and
> > consumer to read soc unique ID
> > 
> > On Fri, Dec 18, 2020 at 04:37:25PM +0800, Alice Guo (OSS) wrote:
> > > From: Alice Guo <alice.guo@nxp.com>
> > >
> > > In order to be able to use NVMEM APIs to read soc unique ID, add the
> > > nvmem data cell and name for nvmem-cells to the "soc" node, and add a
> > > nvmem node which provides soc unique ID to efuse@30350000.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > > Changes for v8:
> > >  - none
> > > Changes for v7:
> > >  - add Reviewed-by
> > 
> > What happened with my reviewed-by?
> > 
> > Best regards,
> > Krzysztof
> 
> Hi,
> I forgot to add reviewed-by. ☹

It was there already, so you had to remove it for some reason... but you
kept the changelog.

Best regards,
Krzysztof
