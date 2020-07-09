Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA721AB30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGIXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:05:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45948 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:05:09 -0400
Received: by mail-io1-f67.google.com with SMTP id e64so4082311iof.12;
        Thu, 09 Jul 2020 16:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0WtOOB6/vgaGNr9jZL3i1Ni5BCDkN9eW0m6vKmF8dfA=;
        b=kpefmHlS0hTsbhWMTx3jIU14V6pVsIC3eM9UcUAe+dYCgn9kmyCrgo7mJ8n9HwFEzl
         tsEyGhGGuh04MMGmIxExoh9VtNrRA9H2L6Jwp5kUy250VjnhlTe7gWCs17U39uA16veX
         myNEKp4ECcIKfdPWWFiz7QZzNsv8cp2QLtCWASwWSSCqiezeptm646Z0u9Oiv7OEG8W9
         XaYIAZYIQonYa62ENcdwOTeiYpmvQ4lXzgXtWarRJxDK/ILkeA0GDv2VaDTss87S+LbX
         Ea8URrYONjeQWIgshbcRxAQ/6W4GLuiJ45ZClDWEOrXuvu6QQXhBpCHF5vjVnujF/2kV
         FQEA==
X-Gm-Message-State: AOAM532+AvfXbWULQLkDM41ZviLnD6ijFRWCBq3cQrtgdGZsTouBTqsj
        ipVKBDrcgzMh++D6UIXNMQ==
X-Google-Smtp-Source: ABdhPJwsyIN0+fSiR56PZWSugu8oN8yNRvBMOpwUI8nTXuG5I3KxreVj5+VgdJqZs+Atys+F+w6Yag==
X-Received: by 2002:a5d:9306:: with SMTP id l6mr45717095ion.105.1594335908860;
        Thu, 09 Jul 2020 16:05:08 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id h5sm2431875ilq.22.2020.07.09.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:05:08 -0700 (PDT)
Received: (nullmailer pid 1059673 invoked by uid 1000);
        Thu, 09 Jul 2020 23:05:07 -0000
Date:   Thu, 9 Jul 2020 17:05:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/12] dt-bindings: vendor-prefixes: Add 70mai vendor
 prefix
Message-ID: <20200709230507.GA1059621@bogus>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
 <20200616121525.1409790-4-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121525.1409790-4-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 21:15:16 +0900, Daniel Palmer wrote:
> Add prefix for 70mai Co., Ltd
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
