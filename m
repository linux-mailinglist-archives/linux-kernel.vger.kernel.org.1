Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE291FF676
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgFRPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgFRPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:22:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86643C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:22:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s23so2925923pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZNoqRPw3UvDcF+Rzsimtu2GK82CnXwvp0FPvlYQpdcw=;
        b=1PnIVNDxQSN5j5vrmKWmjKk5kmBqH85AaE3s5U5t0oCc6NdMfCY9HGEUX9pFwul3y+
         +BHcqOAc2kIIMm4anvzwmyeKM6Vyn+9+nHejZ54qkAmtG+4kQzhmfdmIvRrakDqzHjM4
         LOv1PCOCm7exPrzOFJ2VkvZKN8pRb2/+DRlrtGqBPz1zx+pMMWDipwptcrMwa5jR1tm7
         6KgM3GDBgxH0Zm94UZMMXxprukIDJc3e2SakoOLLYAgfOaGliP4OhTxFP7/Nc3iYGUyB
         ivlANUrW0TnpA51kn+i5bycaWBWO3zsJ8mX5IR1vkRWtCXPkiKT7ubnP8F74Le0GVxoL
         6z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZNoqRPw3UvDcF+Rzsimtu2GK82CnXwvp0FPvlYQpdcw=;
        b=il8ll3Q2HNI3IFP2qyGU2vixLutjwIaZDzaG/OaTVHnePr9ogZNN5cAECXhkWwgFjk
         3yGAUlyVXXZ7V3C3qofcRWDQAw2umrwFefKtxhWc81dqdmHEnhPscln+vMMGxsIEqW05
         ERSnh0v/f0gz8WS8gcp49pyIDyLvCr4rIQGwYDz/QkbG7bVWuvKLkQR/aCIXJTdqdQem
         V/qLb1OXAWPtCWh1f7T8zXT5F7iJQBoJdGR90W9ec7GD/pMKFmWdT73MxwLC7DW+Yxvj
         xaep/KBcFx1AO3AD5Elt8DqoGOPeSO7NhheoRw5NvU4w2K8gLZe7CNY0I9n+J96w0Sd3
         45rQ==
X-Gm-Message-State: AOAM530D2h8B4GMpMX+SXrnHrYKxkUM/wRegnqILrhTQ+7FYU+NxSRTV
        EIVntxgykkben+D58k95bPaAuOGz9yBjVA==
X-Google-Smtp-Source: ABdhPJyXAYrQu6pQf6eHrkAHJLt3OfJKnWtPAwjcAHT2zgBxOhwj8nOo0MizTV8gOf5RY7dWoL/23g==
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr3829316pgn.391.1592493719358;
        Thu, 18 Jun 2020 08:21:59 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j123sm3283831pfd.160.2020.06.18.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:21:58 -0700 (PDT)
Subject: Re: [PATCH v3] libata: Use per port sync for detach
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     John Garry <john.garry@huawei.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603074819.21639-1-kai.heng.feng@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <88430982-e948-be34-b47b-2411b31eb187@kernel.dk>
Date:   Thu, 18 Jun 2020 09:21:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603074819.21639-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 1:48 AM, Kai-Heng Feng wrote:
> Commit 130f4caf145c ("libata: Ensure ata_port probe has completed before
> detach") may cause system freeze during suspend.
> 
> Using async_synchronize_full() in PM callbacks is wrong, since async
> callbacks that are already scheduled may wait for not-yet-scheduled
> callbacks, causes a circular dependency.
> 
> Instead of using big hammer like async_synchronize_full(), use async
> cookie to make sure port probe are synced, without affecting other
> scheduled PM callbacks.

Queued up for 5.8, thanks.

-- 
Jens Axboe

