Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E651E3A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgE0HbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 03:31:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42096 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgE0HbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:31:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id x27so13848070lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVPFO5jTSXVyfieNIZ6aF1nejaxIKxaWPNihWiOu9rQ=;
        b=eNpK3K2/QICeoKYaVGngdK+Y0DvPJeCmiZTZfHKkims0+V4SqBnaIdwRZNgPL1bahm
         nyKkOtoGpYDPuLU5IfGZ8YEl0B4qmRwtcDWjKkt/YbqX4eAd6o6uvbs3Mo1tvKHnfIC1
         E/432SqNxxrhed9iFso0P2vFL50cqhkuH5KkdgqoTfmwgplKtjunx+EGuN3osvAA8IXo
         MQiFhECaZsCXJaDhgZ8YF0W6CP4VE7CTMDyH1Hi51SyIUrbFPMyscyjMiUQ3zJfdbL+D
         krKCZquDiWR28yiCLqwtHQL7iQtnmTjCmLJN8ubVrzp708ZwkFdXrwUfutsPCL0UWDMt
         of9A==
X-Gm-Message-State: AOAM5313Wd+iYdJKv7ZQ0l7vY/uFLRHw1DkFnW7YVpp4rSZ213c4rj4R
        4qFhUFZNkbOPg5zkaaqtdIQ=
X-Google-Smtp-Source: ABdhPJxAskCPTK99I5IrpLL4nKStzonimfUsm+hzeWWsWEGoa6FKOqqlQqt9KCTaiViqTEcx5bxJFQ==
X-Received: by 2002:a05:6512:3208:: with SMTP id d8mr2455203lfe.38.1590564677228;
        Wed, 27 May 2020 00:31:17 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a7sm617349lfm.4.2020.05.27.00.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 00:31:16 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jdqWr-0003cc-5A; Wed, 27 May 2020 09:31:09 +0200
Date:   Wed, 27 May 2020 09:31:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] USB: serial: option: add Telit LE910C1-EUX
 compositions
Message-ID: <20200527073109.GF5276@localhost>
References: <20200525211106.27338-1-dnlplm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525211106.27338-1-dnlplm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:11:06PM +0200, Daniele Palmas wrote:
> Add Telit LE910C1-EUX compositions:
> 
> 0x1031: tty, tty, tty, rmnet
> 0x1033: tty, tty, tty, ecm
> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>

Thanks, Daniele. Now applied.

Johan
