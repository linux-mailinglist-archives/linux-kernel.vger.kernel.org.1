Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E995274E57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIWB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:28:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34447 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIWB2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:28:41 -0400
Received: by mail-io1-f66.google.com with SMTP id m17so21967647ioo.1;
        Tue, 22 Sep 2020 18:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvvIo3jDY0VYkefQndKzNnYYk/UrLw7GL4P6C4Xiiqs=;
        b=fRgXThDz+uNi9Tmw3OhJDtg0/5X2NauZ1rrq+TvSPJTLRewLe/ZODqrJB+YRB3h45Z
         Yg8m7ZvRpTIOGw+Qqps5FMW+ssRVF/UV5NjXXJ8aSAfGxLGgBZN12i3/K2e0I9GWjtzx
         y4C6ZlfueIJqVNxPmO0KU4Q9Xqsou6IC6smhZP6e4pc8uS48jkZmjhVk0dsQN/4fSleZ
         Ha/0WMdMWxK7JfbAoj7ho9rTSt8lqVqhN9BmabfIlIKX3CvpDWgIqKW4adaaIWf2WQ2w
         1xrSJzr9PpjABF3MOifa5zJVtpkTgyCcE8o/e0iGMYjhhWaDOK/+IawTPyAJu8Wwcqa8
         OBpQ==
X-Gm-Message-State: AOAM531DsIJyDBsivVoxAkxxQIPhpdOKcKNYx4RJD2VBopNRDr0jMxe9
        Ogl5sAlSAJhYAAX1hROiZw==
X-Google-Smtp-Source: ABdhPJz5+rMpCYmHiY5Qrgls04pxpbzB3K5fYJBD9AXk28cIf/T7aHCIGDKW4YFqW+qS0OrsiGCiiw==
X-Received: by 2002:a6b:7112:: with SMTP id q18mr5543907iog.79.1600824520112;
        Tue, 22 Sep 2020 18:28:40 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y3sm2326804ilh.76.2020.09.22.18.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:28:39 -0700 (PDT)
Received: (nullmailer pid 3656746 invoked by uid 1000);
        Wed, 23 Sep 2020 01:28:38 -0000
Date:   Tue, 22 Sep 2020 19:28:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 3/4] dt-bindings: display: panel-simple-dsi: add TDO
 TL070WSH30 DSI panel bindings
Message-ID: <20200923012838.GA3656693@bogus>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
 <20200915121912.4347-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915121912.4347-4-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 14:19:11 +0200, Neil Armstrong wrote:
> This add the bindings for the 1024x600 TFT LCD TL070WSH30 DSI panel to panel-simple-dsi.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
