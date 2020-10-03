Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4960C2825EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 20:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJCSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 14:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgJCSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 14:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601750603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWM0RfrM0HZAs25gIGx3NLfFo36RAwB9ram8EBWXtH0=;
        b=GZdA/dNgTetISJvKA0GhuyfZlqwEPFjnyJ/dfy0/FPIqofXNispA1i0pX8zPn3aIlxtBah
        PN00URs8rm7BwF1BxiM9QEtElv12C14VlYae6MhmiQD4dGe4L6DTlts5pAMBca8Z2W8yq6
        4Kf8RUVA87GLGDe+cz8m2ZkEAHJSPac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-XBxCzSEXPWS7Mu60RHBHhg-1; Sat, 03 Oct 2020 14:43:19 -0400
X-MC-Unique: XBxCzSEXPWS7Mu60RHBHhg-1
Received: by mail-wr1-f72.google.com with SMTP id l17so2043204wrw.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 11:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HWM0RfrM0HZAs25gIGx3NLfFo36RAwB9ram8EBWXtH0=;
        b=Z5cfUBF6hDKMSb/HZvF4Dvqujlumh5YlumAwbYcOQKLySIN8DuLdLom+C5dagTDsZo
         jkFVel8bTa5UUvKyCUuPL35Br2Zf1S0nS6lo2If+Vh6Uky62GzY+3M95z319X86+NglN
         a4CE98iq2anxcG8kAGieofsdCzFE4uK7Y4u34eCi9TaLYaWFrqlAGr8AxYosKLVejR8+
         8mXjssUupSCiJR13w6Fj7t4K0H0F8lz9jCg80gxD/hiZudUWfhmgIPBNu8rp9OZyvySA
         EV70m2UBqRV5cbVOkcKkXiLFGoDCNM0kJ3ceHq4IcrGtU+S0iEVkSbd+D4icFs1MRfWb
         FYMA==
X-Gm-Message-State: AOAM531/9X5lkkQcX35SM8AoF0dS6xcBJotU3r5GzcXbF7xL3o+IJXYk
        bWlnlzQuUaDCAvEufFJXVeFFZ2EdATC+8YeAbEPi88BgdGB6f5UFdNuK33bzuXGgOrnOHj4J/ek
        Od53JnkuDx/o6pM6wo4oVdy4U
X-Received: by 2002:adf:e852:: with SMTP id d18mr9744712wrn.40.1601750598435;
        Sat, 03 Oct 2020 11:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy038Yccnpob9//W8sOr1lm3wbsl6dgaQoAhcFw98vUjFVu1T3n44Gs2WlgxSmLiPyyNgs9bw==
X-Received: by 2002:adf:e852:: with SMTP id d18mr9744690wrn.40.1601750598224;
        Sat, 03 Oct 2020 11:43:18 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id z127sm6091271wmc.2.2020.10.03.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 11:43:17 -0700 (PDT)
Date:   Sat, 3 Oct 2020 14:43:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     anant.thazhemadam@gmail.com, jasowang@redhat.com, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH 0/2] reorder members of structures
 in virtio_net for optimization
Message-ID: <20201003144300-mutt-send-email-mst@kernel.org>
References: <20200930051722.389587-1-anant.thazhemadam@gmail.com>
 <20201002.190638.1090456279017490485.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002.190638.1090456279017490485.davem@davemloft.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 07:06:38PM -0700, David Miller wrote:
> From: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> Date: Wed, 30 Sep 2020 10:47:20 +0530
> 
> > The structures virtnet_info and receive_queue have byte holes in 
> > middle, and their members could do with some rearranging 
> > (order-of-declaration wise) in order to overcome this.
> > 
> > Rearranging the members helps in:
> >   * elimination the byte holes in the middle of the structures
> >   * reduce the size of the structure (virtnet_info)
> >   * have more members stored in one cache line (as opposed to 
> >     unnecessarily crossing the cacheline boundary and spanning
> >     different cachelines)
> > 
> > The analysis was performed using pahole.
> > 
> > These patches may be applied in any order.
> 
> What effects do these changes have on performance?
> 
> The cache locality for various TX and RX paths could be effected.
> 
> I'm not applying these patches without some data on the performance
> impact.
> 
> Thank you.

Agree wholeheartedly.

-- 
MST

