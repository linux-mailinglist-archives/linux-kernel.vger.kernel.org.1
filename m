Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A921AB33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGIXFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:05:31 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35801 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:05:31 -0400
Received: by mail-il1-f195.google.com with SMTP id t18so3502970ilh.2;
        Thu, 09 Jul 2020 16:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1EOhQLt5rgec4sYdp8BwCYw5u8wh6GqWbPop84Zi00I=;
        b=XjmX0Ktid/KN4TO14T4/I284sofXqVBXiygWFvS2ATEn22MuzstPotbIXT9NimMyR3
         z8yDKCM0Yg9ogvh9NjGdlj8vmn3mWEF4m0kFhaX0uHti8h2Qa3uUjnyPlC89mPEU3Pmn
         YFUUB2KQzmFw7RG8pqTbx3C/qSdn5MGJ8Y4ZMuLpnre63rfS5lx9Ij42bprkLAmlqO/V
         BZzSqsT75q8pFZA3tAQms34snYX+wvuadWAZNBFipvhIvehMFItetCeCa7nwwqLpB787
         a3/70jIC5MHn69it+nN9Np5fSiHac5HEmp6jyRii0Ewu7Ccc6Ki9WF8izP6IF7K+j0Z3
         DdGA==
X-Gm-Message-State: AOAM5319ay0c59+aWs8Zm9Ro8E/tlxgQO3/DrQE6++khrvbm7Oq5O343
        9rDm2VvKb72tNUVwEiyVXABdMcgj8w==
X-Google-Smtp-Source: ABdhPJy0hklSX+iioLZ1lYetbtlBh+V4V+JBQx+uFTBGaDqop32oDKMDUGpiaErTO6Sx9qOuq0oJ2g==
X-Received: by 2002:a92:5a16:: with SMTP id o22mr17998921ilb.109.1594335930279;
        Thu, 09 Jul 2020 16:05:30 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id t83sm2652774ilb.47.2020.07.09.16.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:05:29 -0700 (PDT)
Received: (nullmailer pid 1060347 invoked by uid 1000);
        Thu, 09 Jul 2020 23:05:29 -0000
Date:   Thu, 9 Jul 2020 17:05:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/12] dt-bindings: vendor-prefixes: Add thingy.jp
 prefix
Message-ID: <20200709230529.GA1060317@bogus>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
 <20200616121525.1409790-5-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121525.1409790-5-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 21:15:17 +0900, Daniel Palmer wrote:
> Add prefix for thingy.jp
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
