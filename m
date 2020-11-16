Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763492B5098
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgKPTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:13:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44491 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKPTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:13:57 -0500
Received: by mail-ot1-f68.google.com with SMTP id f16so17051741otl.11;
        Mon, 16 Nov 2020 11:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6I9Q7uYU+1V06QV1nRfkMu2gtpH5bALi2iSib07hAE=;
        b=IbBVHkMM7Ze1vvvUW0xefCsL4VnRmdrt210hT3FY1a8LUotE1GPogegpsXxcJ12h1x
         vlXfzdM3g+v12Dtfqr5EGAT84H69AUJzmmHXCP67OqPhNX2GVZNhDOi+/53SAA38lPjl
         WvJCCiP+4Oe+xPhTqssGnuzC000vBDk+cdDqq7ihgshMUKPlaEztjXEujXefYOCS3BAm
         itOHfQ1t0S8r6+esnVAzwQlVVQNr8HECazql9InEz3UOJE1xWqDOjsq0YS+xuyhTLece
         cH0IJNFQtTLSpN2wgrF61IjFtvnBedVeMPI0M2QJCVlaa/2zgMqR4SjPsProikFhmkwI
         q7oQ==
X-Gm-Message-State: AOAM531E2WBdBfh8kGtd/iR8YPSCp1iLgZaRPe4MHx1Y6GDIGC6kPctj
        r/65RPj4gQJIEeGx8jKmgQ==
X-Google-Smtp-Source: ABdhPJylE0odHk1sUNwAg8pufVRl8nRqtkr00hbaJG1PTMd3S3PhR4MMd5bGJauQ+tZgDh2163zwHw==
X-Received: by 2002:a05:6830:236d:: with SMTP id r13mr630308oth.34.1605554035585;
        Mon, 16 Nov 2020 11:13:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 85sm5015804oie.30.2020.11.16.11.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:13:54 -0800 (PST)
Received: (nullmailer pid 1977880 invoked by uid 1000);
        Mon, 16 Nov 2020 19:13:54 -0000
Date:   Mon, 16 Nov 2020 13:13:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux@roeck-us.net, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-binding: hwmon: Add documentation for ltc2992
Message-ID: <20201116191354.GA1977819@bogus>
References: <20201111162057.73055-1-alexandru.tachici@analog.com>
 <20201111162057.73055-4-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111162057.73055-4-alexandru.tachici@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 18:20:57 +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add documentation for ltc2992.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,ltc2992.yaml           | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
