Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759CB290D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411162AbgJPVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411081AbgJPVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:18:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C8C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 14:18:44 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y20so5661072iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VM4BKyFq44zHNyr7iJQBh+qGeMbatl4uI8njRsnN0bI=;
        b=GuKfw7bHJsHM4Rba90mo9FvaRHxkxeydyfkapiOwp662mJaQb+lbAtD0gDX++dSgLC
         hbUA56GO9KLToe5QxOwh4BjkqZYML1WykNhoa8nq9bBHTTaxPgWa9oXK1eXLkMTR674Q
         LWG3NWbzpXTVkUY3Tm9QQ1fgBAvJzYkRaMqI41IufxMN6Il0bZWDFV8y/stTJVRtPbrt
         LyP/UpNSOh5gLs4YZQUPAUXAD+dsu2VjFwnSX0u3ZlVE/x6JxH2M30WH76LHi57LwZj2
         O/0cLhg619BTRyArDJJp9ldHnPAQtKWAzQ8xiWvNKRA0Aj+fHWZVqNWJKIfe8Lm2XySi
         0/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VM4BKyFq44zHNyr7iJQBh+qGeMbatl4uI8njRsnN0bI=;
        b=cZ8w1pmhlWjlhB2kZfDdbV3MwAP2gKPykerxmNhmqJSUgQTUtIaDlbS66gHgOqNbJt
         9dIuBHmyRPtGdaoamh3yGYfC4xwWm6QpC4jYk1swsRowyN4sVsKGaYbqk4PWPJfRUXXz
         MnT7qCdtlC8i4g07DmUWVX5b0hGMgyMEWsJohhDacHKty8PHK49geB92vTDKDDGBkGO4
         gXjAECAr5naA3FuzvSXAV7tLbl7zdbYf/iz16ELPTQSn4Wh9Ma4YbfsiX6o4alAqdgA9
         WzlEmLShqktcIfTzGw3aO5kiAxaVRM3WEOvYKJe6qO6fd6yvp4WmmM0Ik91XkBj/VDxI
         LyXg==
X-Gm-Message-State: AOAM530qLT8i9b2As0RutR88v4XWlo5eDD/0lAHfP61Mr4jsbJDS5Kaq
        vZfr7iqhzBaEICTEELxqWoc=
X-Google-Smtp-Source: ABdhPJxeyONz6TOyMQ76Xy3aTP1gYEj3iGtnahO8qqw8AWloZDuFxUShMH0vdl7F2FoBrnzzQ/6j2A==
X-Received: by 2002:a02:c8d1:: with SMTP id q17mr4276669jao.127.1602883123619;
        Fri, 16 Oct 2020 14:18:43 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e11sm3372892ioq.48.2020.10.16.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 14:18:43 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 16 Oct 2020 17:18:41 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201016211841.GA1634455@rani.riverdale.lan>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
 <20201016162759.GG8483@zn.tnic>
 <20201016164755.GA1185111@rani.riverdale.lan>
 <20201016170726.GH8483@zn.tnic>
 <20201016172058.GA1246432@rani.riverdale.lan>
 <20201016173232.GI8483@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016173232.GI8483@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 07:32:32PM +0200, Borislav Petkov wrote:
> On Fri, Oct 16, 2020 at 01:20:58PM -0400, Arvind Sankar wrote:
> > This patch depends on 1 to initialize boot_params before
> > initialize_identity_maps() is called. You want me to rework it to avoid
> > that?
> 
> Yes please. If it doesn't become too ugly, that is. If it does, then
> we'll have to think of something else...
> 
> Thx.
> 

I just sent out v3, with the patches reordered. Maybe just pick up the
fix for now, and the other three patches I can resend sometime after the
merge window, along with other cleanups I've been working on.

Thanks.
