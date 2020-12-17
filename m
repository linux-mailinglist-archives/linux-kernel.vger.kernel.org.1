Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D0A2DD35D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgLQOzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:55:49 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19267C0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:55:09 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w18so13903570iot.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AppbOyrBaJen3npr6us/u+3s8pRHAJIQTjC/7eMkWrY=;
        b=qIsNU8MNaXfORjHakfIhVA6M0I+jhauT8ujQjdTh9pltOmusTdjtS6vAZtGFqUKa+h
         1djBuHsK4XxRHHLJzWI3bGidYfLa3CWko/3FVyNpI3oJJYnYAVLWJBKKhi3VfLGOs7dX
         W1X16QmHGd/vEu/IxDQxMe5iJvYn1J/20qdKaMkr/uFQe1EDwdejrAd911mA6PbqjulD
         PwkyKPXO0j4zqejFvZzCV51KA5NnIcxg87o90ufkWZY8neAizIwC0A8kiIdXUb/QGyGo
         MEmaiaZzG/uVrv4jVgLnAQ8QYEJYDHAUzeoVUvCp4fNKcqWiBLD1fxGUdXNsbjG0Keqx
         ZY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AppbOyrBaJen3npr6us/u+3s8pRHAJIQTjC/7eMkWrY=;
        b=CtVrNjj4nm5PlJCXMMkERExil4WTLqKqY6WsaL1K/TXOKNs11tpDNRC7S7CwmZnuyZ
         dHpD7Q691kEWvVprcorsQbYgGM1a5Eu9NegukqDLSiymALB9sNSeQHob6+gAxCRcxvgJ
         kT01PLqEaWSlvtrGO/p3jlwP1febFH2pZ3gcXzfHs8qhLoJU9urt7g3RWWQDtnzAwHO/
         BZ7j98Jb64glD+GwUinpt3OkipV2Nqql8p1BXdL9eqzFlu3RAaJmH+DICXx7RM+RoIe2
         pi6MOm19lSbs+BBHGV1k+E3Ug4D/HOX7Oua0DtZvSf+VMR9AOoE92IO40PjRqLKqJPcQ
         496Q==
X-Gm-Message-State: AOAM530bxUr7wxfcOUfnxtukcU9V5eJUviCgiONNywVgTcJKeolbaEA+
        nkHOwHOtRa4J36wDItf3oN4wguQDa2wgaw==
X-Google-Smtp-Source: ABdhPJwfMNgZvVnqWHpCY0jEbFdtpsS2a0qvoidjGtaw1ygKCvI5Uzf8bManknMBHDhGm/ob4gK8MA==
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr45693684iow.131.1608216908061;
        Thu, 17 Dec 2020 06:55:08 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p11sm1762461ilb.13.2020.12.17.06.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:55:07 -0800 (PST)
Subject: Re: [PATCH] nbd: Respect max_part for all partition scans
To:     Josh Triplett <josh@joshtriplett.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a3c0b4b-52d0-b4e0-182e-c15f2a80d348@kernel.dk>
Date:   Thu, 17 Dec 2020 07:55:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 1:58 AM, Josh Triplett wrote:
> The creation path of the NBD device respects max_part and only scans for
> partitions if max_part is not 0. However, some other code paths ignore
> max_part, and unconditionally scan for partitions. Add a check for
> max_part on each partition scan.

Applied, thanks.

-- 
Jens Axboe

