Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3372B2A7C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgKEKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:54:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39653 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKEKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:54:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id e18so1038508edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 02:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2SVBRUlRYCZANib84MDUTELyGkg3kBBPrSWfuqwYHA=;
        b=nBbOPgC5bqI/kH1AZd2I45UUNrmklwmAoyISmoFh0alSj5tMkTRVce/uQTGY9vRsKc
         2u9E3T3GMQjkcOFg7Q45UWJ3URB7K+9zWfOmZnDKOkDhzk42Cch6FQI01kGq5MUDurur
         SSUbT5TQwATw4qP0nC255jqYPE1js9w4SidjXxvFTYZ4pNCoDlL5VMsWSFe+J8AsrTqL
         U61eZRqnu9ZTybBouv8fctM/s4g27IuXtTWmnFk/nyJIPC0WuXtoZQkF+YtmMRU/714K
         N30XMamZIlKiExZerErGx0nkbvWqlIPttoklJkDhPATWfaNYwXEPCTd93v4HDALfxniL
         oYow==
X-Gm-Message-State: AOAM530qs8Sj3FNhoFakmZj9jDLqucR89JMlVnTmha9t52yDKIVjsoOW
        HiLfytahEJNgBECkfzpDeAK4WvdU1S8=
X-Google-Smtp-Source: ABdhPJxgo6MTPvWL5gv91m8aQ9NelclIF9qb63XHR/5aIrU5snAL2nSf1jHuwWrbjSbdu1tOm/u35g==
X-Received: by 2002:a05:6402:1042:: with SMTP id e2mr1949037edu.320.1604573676175;
        Thu, 05 Nov 2020 02:54:36 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id q9sm701442ejr.115.2020.11.05.02.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 02:54:35 -0800 (PST)
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
 <69E3975E-A4D0-4472-80F0-9FAB2E0024FA@microgate.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b2698a7d-1821-1cbc-3249-6888ede675f1@kernel.org>
Date:   Thu, 5 Nov 2020 11:54:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <69E3975E-A4D0-4472-80F0-9FAB2E0024FA@microgate.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 20, 10:39, Paul Fulghum wrote:
> If there are no objections to removing the the old drivers (synclink.c/synclink_mp.c) I could make a patch to do so tomorrow (it is 1:30am here now). Nothing eliminates niggling warnings like removing dead code.

\o/ Thanks a lot.

-- 
js
suse labs
