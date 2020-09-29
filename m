Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C727D4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgI2Rq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:46:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33291 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgI2Rq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:46:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id m7so6419363oie.0;
        Tue, 29 Sep 2020 10:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mVned4RG5QRYTOR8H15/jWkAsq+BBK7cREUkxd/Xiaw=;
        b=LMpMfG0UJ4xsTyg0gkhmVP08BqFOES6kdnkAfYnsUhTmwWC8djNkK6Oa2j6Gt4qN6l
         hFlaLhyf7pB+CUU7SzV1CbO9u07VEgRHv4bcgBdMPcOcseTFgn6KpDB6phFzcSNoXaxK
         u/Ys9OTT4BX+mLyFUjXr9/gRVKfgCjVhKP3MSklHpupjj27AP7GDJ5oMxUCtcfEMqTAb
         XnHWWF7n8Qo/lbv/5Lvk+/jg1m5pcoqYgFwFzZhDt8OmchKym2mrZXLzRTRbEjvdyhMz
         s+a1pNuwQ2cX8/hK6NbIaK75G4xlf+wmUv2xgpxZb+WHdEajYnp1WNlQL2MhjIH8JHyD
         jfrQ==
X-Gm-Message-State: AOAM533VCytkNma3Cm1IS6AWYKCVaBtKK9DFnXpeAXuHdnk1M9Ejq1+7
        5vjuXfeZUUwLE5ZeRNHL/lkuZLo8Q80f
X-Google-Smtp-Source: ABdhPJzPinEAfFDFESHqHJK2pNpDC0q8yKXQiSUiTSjbR/vQnrIORvLad5CBhsZcQqwQ5wDx1PTgIA==
X-Received: by 2002:aca:2106:: with SMTP id 6mr3418235oiz.115.1601401585622;
        Tue, 29 Sep 2020 10:46:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v76sm1138615oif.58.2020.09.29.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:46:25 -0700 (PDT)
Received: (nullmailer pid 847532 invoked by uid 1000);
        Tue, 29 Sep 2020 17:46:24 -0000
Date:   Tue, 29 Sep 2020 12:46:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] dt-binding: display: Require two rests on
 mantix panel
Message-ID: <20200929174624.GA832332@bogus>
References: <cover.1600707235.git.agx@sigxcpu.org>
 <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
 <20200924193807.GA1223313@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924193807.GA1223313@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:38:07PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Mon, Sep 21, 2020 at 06:55:52PM +0200, Guido Günther wrote:
> > We need to reset both for the panel to show an image.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  .../bindings/display/panel/mantix,mlaf057we51-x.yaml       | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > index 937323cc9aaa..ba5a18fac9f9 100644
> > --- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > @@ -35,7 +35,9 @@ properties:
> >    vddi-supply:
> >      description: 1.8V I/O voltage supply
> >  
> > -  reset-gpios: true
> > +  reset-gpios:
> > +    minItems: 2
> > +    maxItems: 2
> 
> reset-gpios is, as you already wrote, defined in panel-common.yaml.
> Do not try to change it here.
> It would be much better, I think, to introduce a mantix,reset-gpios
> property.

Yes.

You also need to define what each reset entry corresponds to as the 
assertion/deassertion order could be important. You might just do 2 
properties with <pinname>-gpios.

Rob
