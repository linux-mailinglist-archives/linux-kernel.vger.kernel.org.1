Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAC282C8F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJDSdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbgJDSdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601836427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wt9msYI7XrCVAscXBqWyRdDyyGcbJ8JffuRgtP6fprM=;
        b=VvkqdZkwtAzOHvlHGK+p2M/41Rx12jtErCOp/7YQXrBku+Me23DLe80SXTIjZZPV7xQ631
        wSpbKRUZTV3Q3mHL9o4J278zVS/BnOvH3yhf7X5+4SweRyopQE43/WuWDHvlYGUXtKPlH3
        cowPxYQbF6YmhfEq/nniBYsipXyy/oM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-7EWn-lsbO6Key3oL_rDt5Q-1; Sun, 04 Oct 2020 14:33:46 -0400
X-MC-Unique: 7EWn-lsbO6Key3oL_rDt5Q-1
Received: by mail-qk1-f200.google.com with SMTP id w64so5116672qkc.14
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wt9msYI7XrCVAscXBqWyRdDyyGcbJ8JffuRgtP6fprM=;
        b=fbUdQSLSqKGyGf2yV9ECXpOnDOEhuKf12uF9dTFMd0kUhglohb4iwFDgQwVMSUjM05
         xdEH2umxypFkUJXkPlfltYuudPJ553R1cDo0RG9KTKRye7h7FslAbzDOSkEKKNBandy/
         SH98EzevZ9Zom7WydUd/HBv1GPrg+wcVg0pRIPRl10dh7abarSDAv8JN6LjPd2vDMwYi
         hDd44UmIvnlyilWU2KgiTVDRCaXgHmOIVecE36PhGe3MjTCdi7Xt1JzA/h3vam6a9JTI
         ekOPx5NYQjZyfUi1DnZJJcpBMJ9OZ3Wts4GHk632Jwk3ZWtP5g00ZgBkFrHQ4AJEjuNC
         lW3g==
X-Gm-Message-State: AOAM530PYzAY8Fl48+Bvp0SDdUfLbQLW2TrQ82C4x+RXbykw8HUfZYy9
        ElsF1lBEPuEJuFBE4t3GweBqlZShZfBNUbsAGVsxlQYMw1qlLtvj2T+57MpiHt+ICmAe8hORLX+
        jx2fCawpZLv92455OIeYG+nnf
X-Received: by 2002:ac8:4998:: with SMTP id f24mr11266952qtq.276.1601836425915;
        Sun, 04 Oct 2020 11:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1NoWkwggkaQEQkuWQWG/uYkcKdHfEXX/cHfTxgg/H6Q/kwK5FxkcMLGVeYSOJ1AogMlmT3Q==
X-Received: by 2002:ac8:4998:: with SMTP id f24mr11266937qtq.276.1601836425762;
        Sun, 04 Oct 2020 11:33:45 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g14sm5739115qkk.38.2020.10.04.11.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:33:45 -0700 (PDT)
Subject: Re: [PATCH 09/10] fpga: fpga-mgr: zynqmp: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-10-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0a62a6e9-ddfd-e279-7889-a64718ab0ad1@redhat.com>
Date:   Sun, 4 Oct 2020 11:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-10-mdf@kernel.org>
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
>  drivers/fpga/zynqmp-fpga.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


