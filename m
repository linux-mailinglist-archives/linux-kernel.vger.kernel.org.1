Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01806304FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhA0Dd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbhAZVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:20:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4CC0617A9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:17:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s11so21502626edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nELwzlUlP6axkorz2djr4guRUf+IWYEa8K0PWf9nTOU=;
        b=MI5Yn4GQix/Onk1AXDBpkLu8gGJ0+ZJPmdZJTwQ+kS11QNftnWwldp71R0ffDbjgXX
         voO4MnYL/dzs58rhk5fBEN6adzDnXRGW837juTSJNruW7OZEYjPc56ZtRTEke1r4PyjX
         WSWvv66Vf2X++L3OgVDMtnMQ9x2VWL0J3B7pXqo4VRcb7bgBa7fZmEwWHNAKY6B4AEgU
         QHdEwNehuqYfA7crHzh5zAR6PtxMSWxg3tobFX8qm9djD6gaLWSrs0LPCjNfKgqmpGvT
         TcaLkqPqk3lwS7Nn4qEcNmoK8NpuXEjQUfMSwdwjQE0mHddJYwAyd+u9JbpZVuydv6WZ
         pWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nELwzlUlP6axkorz2djr4guRUf+IWYEa8K0PWf9nTOU=;
        b=qjtqx4HHLBfFF/nYjiBx6+TxKM8KhK0eA+CMocLnIBRGr1Pd79Lh41NWjkHKCb76zW
         02KExt1HE8xYaqbSDMRQ49x37b+glzYuz5qrZKpwQmyL1D/cTR4/Ct6JFxo52857YRlh
         NpQHSXESH0rP4VqzO/L+lBWZgT8x924Zz0pr+7vmjjfSqD7u1fKX7hoWC1splaD7kf2A
         MAqQ8dLvmj4NjTIxuFqtSZEjGMdh7c5+3BrxnIyPDtI6EFGklZ/7dJkRvDFEFFrdopYb
         HPvSL5/tKtWb71aMQM68DRcb1KUoh5+Po1kNoMQk3YuL/bFtvUhInYjgjRpKQigLffwN
         WArg==
X-Gm-Message-State: AOAM530tKgKD5/IGY6BBx2hGv7kfzCE/LNxlPpWkswZLqemPopvCtY0K
        7L/FLjkXLWeR/dDL2Z4R0ENQQp5CsU2a3Q==
X-Google-Smtp-Source: ABdhPJy4wQRLKh/Cy7gtx3UaZtRIBsQTsVIk5N8CGxrOkT2rebKaO5+ZA7CUxEbx0O9LEX4QoSSfSg==
X-Received: by 2002:a50:fe85:: with SMTP id d5mr6304033edt.140.1611695855329;
        Tue, 26 Jan 2021 13:17:35 -0800 (PST)
Received: from localhost (ipv6-64fbc1442191a03a.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:64fb:c144:2191:a03a])
        by smtp.gmail.com with ESMTPSA id p3sm13208836edh.50.2021.01.26.13.17.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 13:17:34 -0800 (PST)
Date:   Tue, 26 Jan 2021 22:17:23 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210126211723.GA17512@portage>
References: <20210110153532.GA7264@ripley>
 <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
 <20210110200606.GD7264@ripley>
 <CAOMZO5DJUm4zutTB1oi5M0zj4_PFZEAbGzX6_LUAkX_dvEz=Qg@mail.gmail.com>
 <20210116124856.GA3406@portage>
 <CAOMZO5DKann0ojZrhjyXOqrRq9owtgrrZTGwttD_bU0-KO=aBg@mail.gmail.com>
 <20210125212917.GA4177@portage>
 <CAOMZO5DiTDQneYMtNBDpyqtYUYJ3AZ_fqWNSyfxWB5AfaNfULg@mail.gmail.com>
 <20210125221701.GA20107@ripley>
 <CAOMZO5A99AJ9NVUmbFr3pE2jxXnQnGNZ+00LHtBTtG3f2mye8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5A99AJ9NVUmbFr3pE2jxXnQnGNZ+00LHtBTtG3f2mye8w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21, Fabio Estevam wrote:
> Hi Oliver,
> 
> On Mon, Jan 25, 2021 at 7:17 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > I would prefer mine, because I got a wrong colored penguin on bootup
> > with yours :-)

The wrong colored Tux is caused by the bus_format:

.bus_format = MEDIA_BUS_FMT_RGB888_1X24,

So I assume I need another bus_format here.  

> 
> I have originally passed .bpc = 8, but looking at the panel datasheet,
> this should be:
> .bpc = 6 instead.

 yes this is right. I found it too in the datasheet. I'll fix it in next
 version of the patch.
> 
> In your patch, you pass the timing parameters three times, but they
> are all the same.
> 
> Usually, it is meant to be: minimal, typical, maximum values.

yes because on a lot of entries there is just the typical value and no min
and max. But not on all of them.

Best regards,

Oliver
