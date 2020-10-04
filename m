Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04518282C85
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJDS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgJDS2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601836084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZlAhULfVsTLVtcLGXdQHxTvGAoPDqzLOQiT01zOsWk=;
        b=NLVLPTb4jHDp36HgpV19Qt5MXotbcR/4RP/k3GHmOove8CyDMKf+gK8DdU7MpssHV4+3ys
        yL1GAPP8U7a09d/JI2gFeGgFttQVkuhwXaFYJr7NneisiHbQiaP8Dy/HdUT1HyNolECL5u
        OykBFKgpTkgEX9ftk3apnRL3e9Axtus=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-3yGFEOIbOPigPjebH1KaZQ-1; Sun, 04 Oct 2020 14:28:02 -0400
X-MC-Unique: 3yGFEOIbOPigPjebH1KaZQ-1
Received: by mail-qk1-f198.google.com with SMTP id 125so5122003qkh.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OZlAhULfVsTLVtcLGXdQHxTvGAoPDqzLOQiT01zOsWk=;
        b=OXAmEtk2ZQ2Y7iyWwECukNg3rC13qpfRiyizbBEMgpblJiOh/kLQssVw/WeFM9Gc5B
         WtdSu+W9fyoJCCCYRYkMOnD/y7MoBytkKJ11onHXb6x9Yevs6jtnlAE+mCMdllxT4XK8
         S4gqlQxf0DczJsSk+Vg8j47ZzO3vJqgzBUNTHXPDkmg6QtuTR7s2WLp71yrf8zMytkG/
         p5uD1ucvPh9PhxesUzMf9WXt4AazFOSw7p3Xdf9Cr4el1uJ23WCSVMkxyaj8RZz8U6WC
         dBKS3XU/6JH7FKokrX8qoLsuKDZJpcXjww853JF0ZjcPaVy08e1ircP8LtNEJPq88KTR
         evYw==
X-Gm-Message-State: AOAM533emCN37CINWcAA3VQKKN2M6C7+KUJYHIt3VzSvuGjFCV6vXfeG
        Quu0/Xa/5IUjZZguQvMhhSXEi9Z2m9aeUEiQeFXFPfyc+nyNYMOFHRCqfH8UHptgmkUipZve+qj
        kDKsMna8poHN2aB0ag+Wp6Gwu
X-Received: by 2002:a37:52c1:: with SMTP id g184mr10524737qkb.425.1601836082228;
        Sun, 04 Oct 2020 11:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBqfHO+uW3HXxKbyd28iWn0CWtaSnOw8xBD9H9JkH15hCpmEp4kmXoM8GoNPyNaiF2TYHusg==
X-Received: by 2002:a37:52c1:: with SMTP id g184mr10524727qkb.425.1601836082055;
        Sun, 04 Oct 2020 11:28:02 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c1sm6207046qta.86.2020.10.04.11.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:28:01 -0700 (PDT)
Subject: Re: [PATCH 07/10] fpga: fpga-mgr: ts73xx: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-8-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1e6057e5-dd9b-2631-9fb5-ef639519b9b4@redhat.com>
Date:   Sun, 4 Oct 2020 11:27:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-8-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/ts73xx-fpga.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


