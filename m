Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA4285931
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgJGHQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgJGHQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:16:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0642C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:16:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 144so822152pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VAMHHTsEYOhpC7nwdJdZa5VIDvqttOjzyBVmzNIOcqI=;
        b=NUn714DvJvDMQIdzlP8THy5CMxCa8J+YmM9WyI5X6ok04Y0zsgkhEjtYuRwrfk+lrR
         VgOoiDHOgKgr3TNlgXUX/FvV61O4X7OCSuzIflNRAUj9iNh1vRXH0LvG9ZlRsnIXVg/P
         G9uO2UMyp0dpxSkQp/vdtVbxq1PjDXqMdF/bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAMHHTsEYOhpC7nwdJdZa5VIDvqttOjzyBVmzNIOcqI=;
        b=QDLXHOdpJrv0HW1CdqLOqZI3NiNGcz2Z/SDeNfWLm+mM+MgjajNP8VrlKghbgEFhYz
         jwrZabAaIA4s+pCYg9+l1hVi+Rs6Ni7F5pc0JcGHa4INgrYzD532OvrnAAE0xfL9dyNR
         TmikdY4JglKaMWV/Swb0bX0Evs69w28H1Jy9k11VwCJVudNGyisEElyxQH9rfmGjwybo
         rS4OimQlhKlQuUahFNnB4/SfA+p9d84BfXADzn454Wl3RbSKMKH3MwFBhhnP1Lovxog/
         DJDI1XSGPFCG+Y7evjRfpGC+NYVwqZKA5spmHaIWU8eaL2bNdSpY1LQntsCLGevIGtSk
         ytdw==
X-Gm-Message-State: AOAM533MNxM5uNpzbLwZNfPfjEibfdD+UoLHNztD9ZcXcbhaeP163BIS
        1PNgQd37JyA8N0NHE/vABr5+BA==
X-Google-Smtp-Source: ABdhPJwIp4NcTjnEGHi7P5Yx9AJ6lFfuLzmNSrv+L/Ys6tbmVmq7YF2tTod4pFVVLpUUX5cujebIcw==
X-Received: by 2002:aa7:8d15:0:b029:142:2501:39fe with SMTP id j21-20020aa78d150000b0290142250139femr1667154pfe.77.1602054963311;
        Wed, 07 Oct 2020 00:16:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9sm1565834pfc.28.2020.10.07.00.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:16:02 -0700 (PDT)
Date:   Wed, 7 Oct 2020 00:16:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] mm: Use sysfs_emit functions not sprintf
Message-ID: <202010070014.76AA763CE@keescook>
References: <8a0d4fc9a4e372b125249b186689f247312d4387.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0d4fc9a4e372b125249b186689f247312d4387.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:28:17AM -0700, Joe Perches wrote:
> Convert the various uses of sprintf/snprintf/scnprintf to
> format sysfs output to sysfs_emit and sysfs_emit_at to make
> clear the output is sysfs related and to avoid any possible
> buffer overrun of the PAGE_SIZE buffer.
> 
> Done with cocci scripts and some typing.

Can you include the cocci script in the commit log? It might be nicer to
split the "manual" changes from the cocci changes, as that makes review
much easier too.

Regardless, yes, I'm a fan of switching these all around to
sysfs_emit*(). :)

Thanks!

-- 
Kees Cook
