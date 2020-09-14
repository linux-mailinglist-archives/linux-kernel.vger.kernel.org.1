Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018BF269595
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgINTYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:24:05 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34935 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:24:03 -0400
Received: by mail-pj1-f66.google.com with SMTP id jw11so396237pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jLJz8cHUvJD6U+g5VUq+RiSZiz07aeWucq22y89Y6oyiqMj2HbmSf1Lm5/34G0L5I+
         +SAbm/BQufz3duK+s2eLZQPHFv41NIiD2uMkGytgM01pDkZeyYfuy8d44ySDvWGe6NI1
         JuQ3JHtAonrcDGcXHP9jDEfTbMX+HArrijET9Senz64UfCt4tx8ECSlaAUm+4sSH6wQ5
         YlxHO3JzGILyQKQPh5RBJ/k+oOEK6Qg0lJQgiyRIWrTMa13ijFveU5wQpJ/h4yR/xF6k
         sYc/DIBZg3Bm423e5tJuXKURiAiwZ82BqMq49PR9iVL2pC5YOyJf+EsH6XnlzqwKjp78
         IVag==
X-Gm-Message-State: AOAM5320G2PQwLkzYh/OsyfAMxRUjqd8Wk/I/ywUh15TmjqQY8TAgC6y
        /2837GZ58M74fLUjC8I5DmB7+T1nAgE=
X-Google-Smtp-Source: ABdhPJyddSjog0goVGlIWPNpsvrBy94cg1B7x5SN1ImNplM7Z38gjz26vYzZEuGzRbr7X3Jw2f/UHQ==
X-Received: by 2002:a17:90a:e391:: with SMTP id b17mr780389pjz.127.1600111443016;
        Mon, 14 Sep 2020 12:24:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4418:ad86:982e:2b02? ([2601:647:4802:9070:4418:ad86:982e:2b02])
        by smtp.gmail.com with ESMTPSA id m25sm10776090pfa.32.2020.09.14.12.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 12:24:02 -0700 (PDT)
Subject: Re: [PATCH] nvme: tcp: fix kconfig dependency warning when !CRYPTO
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     minwoo.im.dev@gmail.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu
References: <20200914150120.449602-1-fazilyildiran@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <52431216-658d-1909-e460-0e15c766ee07@grimberg.me>
Date:   Mon, 14 Sep 2020 12:24:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914150120.449602-1-fazilyildiran@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
