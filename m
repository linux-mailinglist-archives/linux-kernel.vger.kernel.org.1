Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4382F27C2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgI2KvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:51:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39382 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2KvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:51:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id q8so4937679lfb.6;
        Tue, 29 Sep 2020 03:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YPBRx3wAWfkhorFVl+9CpG6/D2xfzqF7/3IuTnucMg=;
        b=kBKWp1jLWtjibK3rLPp1FfemyoK/Cq/Yiy162evw3R/dG+qpx/2fNaH76uJWc7gqsn
         RLr2xrOjdV/wcI0JEK4UvQjmcaCjb2RNeTv9MsuI632i/izO7IPLQfoVrVus1NY7gCIb
         xNdIBPCCwlYonh9BT29PaFG/PYqPBSTuQJC24r76grmKZ2PGk0rQnEoMtol3KTPx+dc3
         gAzImOaPuG/X9/BO61eD0GArUS7PeYGwuT5ddvhXZQ/ok1Xt7TyldEYNbW5vBd+8eKU5
         4g7TqB0V4852fag0SAgf52l/E8GI/hePhS2vkYjOw4Vibo2wgMjMDO8qBwfEy8IM7dcT
         ZCGA==
X-Gm-Message-State: AOAM531VvpoETL6qEiK7iSShXplDXjCWtuoVPDL0G6gtwGo+0ckcefyH
        t5WFaRTJXRZlWwlZY20DFRM=
X-Google-Smtp-Source: ABdhPJxNrKzvUv2KgNBu7Eb0OQBGQKaLOuq6rS1c+GgKOnN8JWTnI9ygIPumPGCE+OrU/EcLeltC7w==
X-Received: by 2002:ac2:5597:: with SMTP id v23mr915741lfg.5.1601376676145;
        Tue, 29 Sep 2020 03:51:16 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id p9sm330528ljj.52.2020.09.29.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 03:51:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kNDDx-0001zH-5F; Tue, 29 Sep 2020 12:51:09 +0200
Date:   Tue, 29 Sep 2020 12:51:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: add device-id for HP GC device
Message-ID: <20200929105109.GD5141@localhost>
References: <20200924062745.5791-1-scott@labau.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924062745.5791-1-scott@labau.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:27:45PM +0800, Scott Chen wrote:
> This is adds a device id for HP LD381 which is a pl2303GC-base device.
> 
> Signed-off-by: Scott Chen <scott@labau.com.tw>

Applied, thanks.

Johan
