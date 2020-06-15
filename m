Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941851F9CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgFOQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 12:17:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35912 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:17:36 -0400
Received: by mail-io1-f67.google.com with SMTP id r77so18530103ior.3;
        Mon, 15 Jun 2020 09:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gGkie1VJgyejolWVwkstnKk4jWEjffhAsOsdBf85vU=;
        b=pzhfpJHa0ofgSO67tNRjW60XahuIAkdogxM8FoFMlsHa3G3d/n+l4dqhnSxF5hILMy
         YDpAGpCl6zgEnFdgGfPjr9Y3O0m6FZLhVBOsEyylZWfp9Xa7Q1Lzh07D0Taq94Hdhn/l
         T/++bSCEYkDLNUWlTIKTFUhdgDuhpIPl/hJtIPiwRmQsUPNIh9/PuHEL69wbFOuKNOiY
         bZpuZhTPz0CmPv8HuSK6JzTXKU09LzsMKyH/7SyIiZVy5AjyhQO9tUrgCNCyp5Xl5ih3
         QIRpO9GMA5wI5IYOIHohP3dcxwuYIsFFdn+retCJ4F7Z1xFGKSi9k+im8WzbC6ySLH3m
         t5ZQ==
X-Gm-Message-State: AOAM53152smY+wV/sNKCwCSMQ195+VEVhOqHxHxZlZXvHmnRZ/cw1IS4
        IpMvCwGEvLDogxHsKw6jaaVf2ms=
X-Google-Smtp-Source: ABdhPJw/KDrnSwnnbddf4RcRgxXREh25qGZ48O6ynKO5qh7LxGxzK4wVJUt4len6bxDotbgeYXKrsA==
X-Received: by 2002:a5e:dd45:: with SMTP id u5mr28250638iop.118.1592237855286;
        Mon, 15 Jun 2020 09:17:35 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n12sm8201702iog.25.2020.06.15.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:17:34 -0700 (PDT)
Received: (nullmailer pid 1880059 invoked by uid 1000);
        Mon, 15 Jun 2020 16:17:33 -0000
Date:   Mon, 15 Jun 2020 10:17:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH] dt-bindings: property-units: Add picoseconds type
Message-ID: <20200615161733.GA1879978@bogus>
References: <20200602164219.3159-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602164219.3159-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jun 2020 11:42:19 -0500, Dan Murphy wrote:
> Add the '-ps' picosecond unit suffix for property names.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/property-units.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
