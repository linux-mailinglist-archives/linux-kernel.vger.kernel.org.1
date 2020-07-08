Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EED219381
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 00:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGHWdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 18:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGHWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:33:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B1C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 15:33:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so112119pfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXCFTCxGdtV8MyFCzLPx+cLEa/wOMXI2VsbmUQ1pcc4=;
        b=aKLNGyqbfjlfypU3XSMi37ElWycSd5QOuRPRrHJZ4agy9sAPP83A9uImVzcMrPsCyW
         v4YrXUXCFMXFV1OPnsI6cv6ewTt2HnhMuY8YGdzuPwtivUTysB/nKgsLLCTDm5GGAfs4
         FwEZP9zGAZc1EbElR2XmPp0/xhwzO08Yc1gtgUKbC7+cN7/oLMht6hdbtTqJ1LHZFP75
         pK4yzqjIliJ8DsH8cNHobVsZaYyZWgTSGzQ7tS4t2UZYxVPxgNmD/45Rz9eSMRxIZ1Ta
         D477T9OBtjhr0bN/mqQaZX8WtKPXbQ+ZtnMtbID3Gat5wHy72kqpQR8TXvXdq5rk2wlR
         v1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXCFTCxGdtV8MyFCzLPx+cLEa/wOMXI2VsbmUQ1pcc4=;
        b=jvkEBXIWvCyId6kKCOCTOpOkxsJ6RS8uVZFiHxZwyDKiFr3ui5Q7uDn+2dz1Pndly3
         WSgI4gpKP85J0BUci8GAu2V6g8hepbS0MnonEtnwrNPy13ct8CpFFdGH1coC5eHphwcg
         JchjA0xp6j/DpcYfnO8efnDo+jdF1h4x1hywN9VumkNYoTJHMvQ6N/jwP+8Yu+rD0vxf
         bsn3qUT/2rX3KAm46is8WSHasqQmm36a3IF30bsC6oVchh8c9asWx9R3IHgRfFzsjtXn
         BAvqoyVnqTEFnJAzyiGOAfW6z9b3bS/tK3EyG3VyyDvFAA6BKTy5hIH79x9j6aJKsLyd
         yhhg==
X-Gm-Message-State: AOAM532P2/1KZyq5fPHEQf+DviGv1vjQoY3MxxD5P5CCle77ePeFNw/w
        HTw77TEf5pWNUjg+VkHaeTI8Dw==
X-Google-Smtp-Source: ABdhPJwmW+0eXcpEdnrPdMds8vC0mMjfwyN7OLN0bdEGS8KuBNIQf3vaSkBw9U+RNKl+HF922AzeHg==
X-Received: by 2002:a62:140e:: with SMTP id 14mr12167903pfu.196.1594247602171;
        Wed, 08 Jul 2020 15:33:22 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s22sm697987pfm.164.2020.07.08.15.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:33:21 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove kiocb ki_complete
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <807e622e-429f-28a0-5756-765648fc5bcb@kernel.dk>
Date:   Wed, 8 Jul 2020 16:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708222637.23046-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
> Save a pointer in the kiocb by using a few bits in ki_flags to index
> a table of completion functions.

I ran polled and regular IO testing through io_uring, which exercises
both completions that we have in there, and it works just fine for
me.

Didn't test anything beyond that, outside of ensuring the kernel also
booted ;-)

-- 
Jens Axboe

