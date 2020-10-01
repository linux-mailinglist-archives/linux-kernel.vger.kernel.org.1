Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C727F8FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgJAFQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:16:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99DC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:16:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e7so3371360qtj.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMyvN3gVuzQBj94keSmCrKk4OuJZbSTTfVDU0BztZ4o=;
        b=AVGBn0+Y6owZXBJwfgazLUzFbjbqhVCnIW+1imTfPSnAc4qi7Pe58QXALxxfEHH7NW
         Vmy+eT2KQGF2AIMXrNIMHPa8N03xNcPDw1BysPzyTAUnBrmDwNyfA8Z7LXmyUYQd1/o8
         RydFp/NoH40fXqP4HLKbi4+nTGK9g3eJjstINt2w+IXfYYh/n6Gm9O/c2LARTFTxC59L
         GmDP40ZpueoCjSn8apq2cXt07EwlpZAZGW7F+u1qOCjoBxwIEqelJpxSQL9IZ5Yl2Uzc
         PyR3L4tECMB7sGhVLpgOoE5R8eq3RouzGk215efLgIqDOVkjiJNv2shFlT1s4Vagg/xo
         8xMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aMyvN3gVuzQBj94keSmCrKk4OuJZbSTTfVDU0BztZ4o=;
        b=FU52hdF3HhdNmx9VeJlcKwv0mjqVfZPA2gG9XlLYIGg/JC6g7tCi7jG2Y4xFRBa/xG
         PCzDyiOB9j1Edvnn82oHdT7fMxBE0S6mVZt1s8VPQqjLF5+02yudC5Y8CFpzA4x5PQsS
         Q8bzZ6Ff8fb3/SN6m+POfkOXbgSFucjRzf1fOOzG7maHctYV8n2l5QYF+GHBTKJIEUPZ
         VM0s/e0B9eoAnc0cSzolMVMjVdlzye3qGxceQGWFmuHM00vx0IDJ2u7XrpbMYdi9R4rP
         8E0u+uP7gzUPyoeQIBd1YI31PsSi88GgLbZKnHLaMyaOKdobhD7U/gYg8jMg1kdPzqNx
         hShQ==
X-Gm-Message-State: AOAM530ZaTespcYXDvB2uR6yrQZxGmPj8ueN6ijGBkhm5SrM92vdOrtt
        lwxFV1eDg7fNC7OdRhKuHV/K1A==
X-Google-Smtp-Source: ABdhPJycizkFTjy7tefZlHhV/5gxSPPlo5/jlzPCRbOXkxTOJNHO7ZWBwNjJw8GrRDEREZvf+fBRfw==
X-Received: by 2002:ac8:4442:: with SMTP id m2mr5933638qtn.73.1601529399269;
        Wed, 30 Sep 2020 22:16:39 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id 16sm4944270qks.102.2020.09.30.22.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 22:16:38 -0700 (PDT)
Subject: Re: dma-coherent property for PCIe Root
To:     Valmiki <valmikibow@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org
References: <1512d7b5-54c6-3b87-0090-5e370955223e@gmail.com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <269995f2-d57b-d218-8730-fe729cc9dec2@jonmasters.org>
Date:   Thu, 1 Oct 2020 01:16:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1512d7b5-54c6-3b87-0090-5e370955223e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 1:23 AM, Valmiki wrote:
> Hi All,
> 
> How does "dma-coherent" property will work for PCIe as RC on an
> ARM SOC ?
> Because the end point device drivers are the one which will request dma 
> buffers and Root port driver doesn't involve in data path of end point
> except for handling interrupts.
> 
> How does EP DMA buffers will be hardware coherent if RC driver exposes
> dma-coherent property ?

This simply means that the RC supports maintaining coherency, it doesn't 
mean that the RC driver does anything. It's a property of the hardware.

Jon.

-- 
Computer Architect
