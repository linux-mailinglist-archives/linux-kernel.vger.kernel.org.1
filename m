Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E72D1441
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgLGPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:01:46 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF87C0617B0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:01:05 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id k8so12426084ilr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/bBHUQrvjqGZKDRY7e20G9Yb5H//5ix3nl8L9R+aPQo=;
        b=xOilBRukRNJyPZNFY5hLbRzb1Gs9g0uZTueG5TRB8tT3qA70yXcj9q5EDzp4VtcJ+n
         IeqTSkXAcWYtIh9nGk2VgDcaOPEppOJBfSjk+27iM1CvC8aPXqBkRUHetHAQqh1Y38Vk
         mmFAXo0XW4k5dHO+p4bVj8WaD8n0aKh1yCAHaRbKmz7qVXpHtuUiqpLis9dzAXq8YZ4K
         deUWEzNwle5vAbGOSYzZHA272ZVfaw9biImJpTUk5aDH6wDtLwp1NWLMDxRfVmtBmVMV
         jqG2jJO280JfegppbOYkop/MJh86fWHqkwYpQ1T0A9S3jFzsNC36Q0eQVAdsYaE0I9tO
         YLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bBHUQrvjqGZKDRY7e20G9Yb5H//5ix3nl8L9R+aPQo=;
        b=A2f1GsKyQYYPQJLmv4FnTL7ZZGyoOFchkS+MThLAAWHiGWvviBH1xPydiZvF333aF0
         7Mj7k/b42xMruaChm2+n+fwcfj2mFDEyp+A/ZUVEW3FvOQwjjjz8BViOV+IQr13HY53d
         v+Rc6Q4I5vj/9rXQt7AN8YU0MRFiI5cRd+OlDCKY8Cp1+MYwWE9JAgoocVok6hU8sycF
         6HzuHngOtgtSzFT2cu0KZexqeibhOy8d6CoddqfEPdg8YB6DRmZDLVwUsTJ6sVnJtPMH
         cpAuaaa1sqSsEENpf+gKBt0mULSczN/I2uVg68jeZ0waSlMLJ+WEWrP6mp1DT9a6ts6U
         O60A==
X-Gm-Message-State: AOAM533e6EtxCUQ5PuD1gKa2TF9fZRXJyDKfwQRfvbNknYK+9cy0ypLN
        cEtmrqiJ38bmrryNAs+cGc0G0lpA9zkVdQ==
X-Google-Smtp-Source: ABdhPJwN5OpNgjENZj6A0zQKCw0NcFFJCeOAZN+qvKhKU+taiVRWJ8xDNSifCkbf29h7nas2WJzkcA==
X-Received: by 2002:a92:6512:: with SMTP id z18mr22765471ilb.220.1607353264601;
        Mon, 07 Dec 2020 07:01:04 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e18sm7455294ilm.77.2020.12.07.07.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:01:04 -0800 (PST)
Subject: Re: [PATCH][next] block/rnbd: fix a null pointer dereference on
 dev->blk_symlink_name
To:     Colin King <colin.king@canonical.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201207145446.169978-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <afd6edda-460c-8488-6e63-438053e88eac@kernel.dk>
Date:   Mon, 7 Dec 2020 08:01:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207145446.169978-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/20 7:54 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently in the case where dev->blk_symlink_name fails to be allocates
> the error return path attempts to set an end-of-string character to
> the unallocated dev->blk_symlink_name causing a null pointer dereference
> error. Fix this by returning with an explicity ENOMEM error (which also
> is missing in the original code as was not initialized).

Applied, thanks.

-- 
Jens Axboe

