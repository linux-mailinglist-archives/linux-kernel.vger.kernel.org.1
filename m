Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322641EF01F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 05:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgFED5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 23:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgFED5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:57:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589DC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 20:57:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so4556151pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6O/8gP+vgsM1SKUrwazGqcFhGPsWzja2ClLLpPozZZ0=;
        b=ijpJNkg9fDCN3j5YOJyLDE7fBzvOwycQs3qssuh7zjEQEU6gYyIcf2y5TH51eY9Ptt
         Rn0+SL7laU1try4AFFixoqpU4IESfaOZbxku2+d1FAUbw7j8WPF4AIIIZNO0JNurjEuh
         Q/aMTXW+pakQr0XBUMVoGOv6NlRDBkuANKe/PtkVyp0JVsoROOW/iZM468gGS7uHRy6v
         r5KBDmazwTmr5MdRz4uj9Pcq428NX9q4X9kKDGAa1tuw2gAzgPkFXyeijSgAUgHCnex0
         3ObylMcwSjpnHVwlzVydaVMYlf9HpRJxHF2pdVeLpHaodptmFXecR5+dG5od8xlJOuAb
         aTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6O/8gP+vgsM1SKUrwazGqcFhGPsWzja2ClLLpPozZZ0=;
        b=qY1Yt/kQbwKwxcBLM2Qdcx68c503NkDfk4wOPAoxzPvfXjDBVmAyQnLEyS6n0XgZ18
         7fa4+OJAamxdLJjLi8WkbAaDdGnViCJBbfKQxOwEtXSvBURzpBAEafyd+LSOk3fA/5uK
         pKCtwL4dRB6GZ7XMkNX9vk6iK67ScZ8kD6TxjFBb/+G7QcktYcvf/+UpsPd9T6GruOel
         STwhbkm2Ukaq8/T6TEW69MYgPGUskdL9LX6Kr21pj8IYiwTn9fiL41wq7Q7aLYKOnoZ5
         8/gCrNAY5e8QbSeqxq7Fv4Ro1YU8tAKYR4bEU4Q6GjZ7JEml5xyrZrmSeH21SHJf3fAt
         IFtg==
X-Gm-Message-State: AOAM531MMYjytV9fj5eQRDs/EzBtAQWF3QHKXiBVvyor4G9fGJva9Utu
        zFoXyIFDWKRdBS1Pf7RqQ3M=
X-Google-Smtp-Source: ABdhPJzzTafB2YWWaTrbUBiaJU7TnJmGUJpOILTnnW8ul9uoHfUzDLABsGjVW7jGHUBGYup9clzaqQ==
X-Received: by 2002:a65:458e:: with SMTP id o14mr4678079pgq.87.1591329462561;
        Thu, 04 Jun 2020 20:57:42 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id n189sm3853211pfn.108.2020.06.04.20.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:57:41 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 5 Jun 2020 12:57:39 +0900
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     daniel.thompson@linaro.org, kgdb-bugreport@lists.sourceforge.net,
        jason.wessel@windriver.com, dianders@chromium.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] kdb: Improve console handling
Message-ID: <20200605035739.GA525@jagdpanzerIV.localdomain>
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/04 15:31), Sumit Garg wrote:
> 
>  drivers/tty/serial/kgdb_nmi.c |  2 +-
>  drivers/tty/serial/kgdboc.c   | 32 +++++++++----------
>  drivers/usb/early/ehci-dbgp.c |  3 +-
>  include/linux/kgdb.h          |  5 ++-
>  kernel/debug/kdb/kdb_io.c     | 72 ++++++++++++++++++++++++++-----------------
>  5 files changed, 64 insertions(+), 50 deletions(-)

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
