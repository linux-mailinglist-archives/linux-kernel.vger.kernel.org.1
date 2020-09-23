Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C16275CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIWQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgIWQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:03:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB6C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:03:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so589912wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bYY4v0xUKW+V9VzHQGgAzoUDOD/hbVajXOB7n6FQAF0=;
        b=jiSXCwcC/9mz3F5aJuG19Xy21Yj23ok0rmXkRUdtSckcplQkLcHXm7ioPtobwvys2c
         /Phb0cg/ShfIOKKhYVjO/GhZHQUDBAHTgo5AggnE0heNoNE8JAdK0KtBtaEJkb538j0m
         vC2VE/HdKzP23D1eb9gngPxlC3s3RYgjxYbVm/WXtwdJmvlR5OOSnDUU8DVeCSjFilwA
         yZkzmbGBmz0Z1eshATp9Zp3hOI7Ci6frBzkrB1eUO8X9AbO0CLVTFws8xAWXhFL5Wrvn
         EpOHtOA9DNkh3hNOvdTR/WSu8vHGSBQ4jxEDTNgFH+MwtB7v9pQJrwY+8lqy0RjPdxVh
         jsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYY4v0xUKW+V9VzHQGgAzoUDOD/hbVajXOB7n6FQAF0=;
        b=U6NjMETeHlkBP/msV4aapVOuLYTK9ef89mKeuvOnW5QCpmKgerOv3Do0W3wupLZtph
         s+Wt5a3niA5nBQLX2xMWZ/VIqklT0AhgXEwvpPvZfcyVSd2nDmPWIK9ZML4PslAWqVTY
         qTgzCPTovUWkuqkyoMEzHngIcjlD9SVsqSdn6FBWeVdofX6bXeE0GzVAV0MFNXmSvS9m
         QGqWKkmMZJqScpgV6F7SO9TzsX0OH9tayLRxnjWIt58o5m695OzAIdIC04yjOuCeHiQ7
         cjpAPaFzDIkbEZNaPHuiF7seOt/GBVi2FT2tO3zIsQkQLc7+rMYiM5zYgrLdqNID9BNb
         EGAQ==
X-Gm-Message-State: AOAM532QNZI1OwFgUCN12cq56gGAL9FBBCYWElwOqq4wprwkMsn91CDm
        Odp1RAuGZU4k8+YoAte0mGS3t77Hszq2uQ==
X-Google-Smtp-Source: ABdhPJw0EElZfNnvTIjIt4ari6nXnOwsimbGPoQwje5oJli7J1WfG5v8Q/oZhnfn7J4307aQbosRzg==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr284278wmi.116.1600877007537;
        Wed, 23 Sep 2020 09:03:27 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id a11sm250764wmm.18.2020.09.23.09.03.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 09:03:26 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
 <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
 <20200923141334.GA16798@plvision.eu>
 <1f65dc6a-50f3-d4e5-f1ce-7a68fddde287@linaro.org>
 <20200923145107.GB16798@plvision.eu>
 <19c5fa23-41c9-f5c7-beaf-aeb9655bfefd@linaro.org>
 <20200923160226.GC16798@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <60233595-b47b-8b1b-013b-51b4c0c7ef13@linaro.org>
Date:   Wed, 23 Sep 2020 17:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200923160226.GC16798@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2020 17:02, Vadym Kochan wrote:
> You mean do not do such func attributes breaking as I did (moved them
> line upper) ?
yes, for consistency reasons!

--srini
> 
