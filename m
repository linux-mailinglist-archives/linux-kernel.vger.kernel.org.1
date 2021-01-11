Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE22F2211
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbhAKVoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:44:13 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38160 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbhAKVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:44:12 -0500
Received: by mail-ot1-f48.google.com with SMTP id j20so326604otq.5;
        Mon, 11 Jan 2021 13:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YYDJmyTvCMUq876NjFDCcLGbzfPkkSf05NMN8BoG/ug=;
        b=EVRfzsE38Xvhl2cBZe3FXyZH6vBDNrBv5TcHrtsPF7PK78wxFQabJ1D8/9JdVlZfQ+
         xF7QT7LZxwj9BM4ZVh2FIaAqG1wr/7SMrZDl6o7X/82gdEpXjA3F83+8NXwlu4q/577d
         5PqmLb3U9QFhVhT06knFk4Mi+RFxtMN8K9FxViovi6+yqe816ABWb2xFJTlkctb6JTEn
         DMENDQvvEr4pl0oWF38iUajXwV6dyFW3Nv7YFO4WC5SCai3DslLdRZO3Oft/VmgPC4O2
         ZPnLcLNPFu+USovCc3MBS5AyCRZVF+y/q0d6OLpLmVodvwkBd3Ee9uwJX8EdSkaRh2px
         g6kg==
X-Gm-Message-State: AOAM532S/NETklQwpZeWTXUKh5keInVH4UC0IkorEK5+TorJ9ELEc8nd
        /v8EpLvR6AaNHLqu4tDmURPG1PitPQ==
X-Google-Smtp-Source: ABdhPJwQu4ByJW5KvBlFIwF5mH1nnxnkWAxvkLskgCP+LxP3RFiR9dfxI8CSLfyucz/ViPFezsnpow==
X-Received: by 2002:a05:6830:15c1:: with SMTP id j1mr748036otr.211.1610401412079;
        Mon, 11 Jan 2021 13:43:32 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g12sm217692otg.10.2021.01.11.13.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:43:31 -0800 (PST)
Received: (nullmailer pid 3111702 invoked by uid 1000);
        Mon, 11 Jan 2021 21:43:30 -0000
Date:   Mon, 11 Jan 2021 15:43:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: Re: [PATCH 1/2] dt-bindings: panel-simple: add samsung,s6e3fa2 panel
Message-ID: <20210111214330.GA3111653@robh.at.kernel.org>
References: <20201230151711.3619846-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230151711.3619846-1-iskren.chernev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 17:17:10 +0200, Iskren Chernev wrote:
> Add samsung,s6e3fa2 in the allowed simple-panel compat strings.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
