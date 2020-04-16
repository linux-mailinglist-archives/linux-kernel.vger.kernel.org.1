Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8E1AB72A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 07:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406287AbgDPFQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 01:16:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45041 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405531AbgDPFQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:16:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so929815plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L1kvrGUoiXArm45b15QIGdZNAqmtJf5JSBfr0zUpf9s=;
        b=RVZq4pqMFJ5kiSfuH5yAGttWLBj1rlARivaozr5+b+XqZTCKPBSdndHR7t81p5M1H7
         bE+7X/qwdEFiuUeOtyleBVnJt/bO9Nd/hIc002YScZvQjrPM7Ni8/XlR03aC6P9hV+OO
         HfIDTN7H+Cft8wW6G3OVB9kUb1NmUiKdS6otTwlBCdX21kGTsfDOa2TfAFWbS5EgoGtn
         KOjfm2m1YCbswn91pced2zmHovlhs7LYHBzU2Pw5PNhJhROZAAOO5cjksiOlDYVQE1es
         5OWMn+dz3HpYPlTHOjD6vtknrU8gbnhhuotvrIABvFcLXU2zqNSGmh9EGePg8pr1sB3X
         /ipg==
X-Gm-Message-State: AGi0Pub5ynnaA2fPAabQYx5PBAWvS8nfW885+v2XRRck5yx5z3us4old
        oH+mF8DdNDmBtrUaK0HbaIY=
X-Google-Smtp-Source: APiQypIpVsdgEjylDE4nRF9wnsxu3YOrsrK2cyyAC7ISFAHOc56HNKvwSjLvuvUA5SWqH2orXvDhJg==
X-Received: by 2002:a17:902:9f8f:: with SMTP id g15mr8072075plq.221.1587014184699;
        Wed, 15 Apr 2020 22:16:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p1sm1242559pjr.40.2020.04.15.22.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:16:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E6C6640277; Thu, 16 Apr 2020 05:16:21 +0000 (UTC)
Date:   Thu, 16 Apr 2020 05:16:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: Drop unused pages field from struct firmware
Message-ID: <20200416051621.GG11244@42.do-not-panic.com>
References: <20200415164500.28749-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415164500.28749-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:45:00PM +0200, Takashi Iwai wrote:
> The struct firmware contains a page table pointer that was used only
> internally in the past.  Since the actual page tables are referred
> from struct fw_priv and should be never from struct firmware, we can
> drop this unused field gracefully.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
