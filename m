Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA522D4B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgLIUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:07:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35610 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgLIUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:07:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so2647350otr.2;
        Wed, 09 Dec 2020 12:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1HYLsU5STC7VJ/5b/CCDAd83oFpysf8ukWCgZzpkajw=;
        b=ODhUBWEkqDHe1S1TbWIbB6qYr/xwIxCAh/0pwJz0LZ9VjnVb+kd3mQOtf2sn5Fsgyk
         Z0vO/Jioa5bNXj+RTRsF+8HzQCW2sZoUsZrgKADJFNW/nbSRkV8CvyWuhr+qhC1DSWDW
         e7rGpZo4+w4PhdbhMxz9cMiiUY6fEhQqabE9nlDqynHCutWPF9HhshHDKyiOgtLmwAZs
         uPXtzemgLkB1uk6ZQ6FSvHe3bV/oUCoeRDrkx8Pin8+VF1EYu+JR+jZAg1+1PwIQFhL2
         7BcpVQ4CZKTIIk0jFd0utTh/rwba8IygoqhOFZyKQvni+CMZgKsz2jF2M+5Yq+mtTKvs
         l6tQ==
X-Gm-Message-State: AOAM531AMiJyRgnw39DIpnP3Oq2u+ufbdFr0gfOS0E7FzSZHDMyh942J
        PFy9WWwEKfDgpq2NWMM+Aw==
X-Google-Smtp-Source: ABdhPJxOThJOKUGLNNKnA40U7hoYgiUoo0PMRXTR8QsxpXqzTs5LHfDKWfPAWRI5HkfXBrHXfL6l/Q==
X-Received: by 2002:a9d:6414:: with SMTP id h20mr3238999otl.28.1607544395563;
        Wed, 09 Dec 2020 12:06:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c1sm585262ots.68.2020.12.09.12.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:06:34 -0800 (PST)
Received: (nullmailer pid 854981 invoked by uid 1000);
        Wed, 09 Dec 2020 20:06:32 -0000
Date:   Wed, 9 Dec 2020 14:06:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kun Yi <kunyi@google.com>
Cc:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        supreeth.venkatesh@amd.com, robh+dt@kernel.org, linux@roeck-us.net,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH linux hwmon-next v4 3/3] dt-bindings: (hwmon/sbtsi_tmep)
 Add SB-TSI hwmon driver bindings
Message-ID: <20201209200632.GA854934@robh.at.kernel.org>
References: <20201202165601.1532213-1-kunyi@google.com>
 <20201202165601.1532213-4-kunyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202165601.1532213-4-kunyi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Dec 2020 08:56:01 -0800, Kun Yi wrote:
> Document device tree bindings for AMD SB-TSI emulated temperature
> sensor.
> 
> Signed-off-by: Kun Yi <kunyi@google.com>
> ---
>  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
