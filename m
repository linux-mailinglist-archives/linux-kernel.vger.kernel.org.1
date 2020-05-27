Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6A1E4052
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgE0Lmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgE0Lmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:42:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5CC03E97A
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:42:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y11so1757048plt.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sZeKxoqsJfHmJKWaGZ+FoPVmzG1uJu0Aa8XuYZUp/Ew=;
        b=VgXBx/n9QvB+YvDn6NYJLz6oVH59pjcPxJRh65BhLU3L7ZuClmM3L2k6D/626PY954
         QQyeqbu8PgPXQCenizXc2i0fC76rQLs8Wigkf4p7SMgbycDSZCVefXPmN+8UV1pawScy
         A2EFa4ZQzatLH1XSkfSK5ym9JQ6jWznNerWZ2LgW+2s1KfuNPJGOAi6T/vXRasdxGG5O
         KuIlKlb5pj0K1QBhbpZ77dep0qpYB5q901mYzXB6eaxxX+5v0gV/Js8+y+LOrYVQC57G
         xNoyGX2CFF0yNvJxOJQSSqMfHZ+KtdVhLsAgGn6KSWyP6rnnd7SyNkWQQHHdVyiC4nC7
         N0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZeKxoqsJfHmJKWaGZ+FoPVmzG1uJu0Aa8XuYZUp/Ew=;
        b=Ow0XhqKQgAWeDIVnF+KdhuMxVa+ZWiIA+0kACzZeXlGxysV78CGCGL7Hxi9tdqpwXf
         THFQVrh4NblAkGxgvgM3PDd81mFGqYX35h63JvcRfmoiONn+hgiJuBotxB8YvIh/8xzx
         XLg2oDUh6cWhVv4wioi/5rXVhE26DH/+uaZR+83WONHf/JmLu7V0bVW79ARFN1RBWhVP
         naFyFjm4XeYE3UU0NmM9r0Kov4iORDybTc0oAYDW17kEUvFoiFDCgpMR/EEY2e1dF1ER
         HAiPaQ58Hs/t48uUt13s8aU1NeHNh2tpe6PtQdUf2DYMTF5pJPhbfbSjZ1Yf349Hf4wa
         fD6A==
X-Gm-Message-State: AOAM5334m9uyIq8Uz1QlwyZHk1KnzRbYXPwMgx7Jkk5036lMVBtAxw82
        Ogsu5zsj8sXTVe6paArTik/vN4rE05MpbQ==
X-Google-Smtp-Source: ABdhPJxEIjzI7FCnmm+8XenXCkMLJM7xic+d04No6urE0jxruzEp+coK6xFyXzPHJohz4u+UUWTTdg==
X-Received: by 2002:a17:90a:26a7:: with SMTP id m36mr4607945pje.28.1590579756112;
        Wed, 27 May 2020 04:42:36 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2cc3:8599:f649:862c? ([2605:e000:100e:8c61:2cc3:8599:f649:862c])
        by smtp.gmail.com with ESMTPSA id v9sm1981838pgj.54.2020.05.27.04.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 04:42:35 -0700 (PDT)
Subject: Re: [PATCH][next] block: blk-crypto-fallback: remove redundant
 initialization of variable err
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200526224902.63975-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <feb4f798-ce3b-6a08-e462-ab23bd223b18@kernel.dk>
Date:   Wed, 27 May 2020 05:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526224902.63975-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 4:49 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

