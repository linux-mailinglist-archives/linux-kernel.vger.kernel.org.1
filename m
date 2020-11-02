Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274152A3131
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKBRQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgKBRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:16:53 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27864C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:16:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j30so18427174lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jasiak-xyz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pOGkUpEQFpFLpHbYfDTTEGGqLarAut/n6gfwvOUJSSs=;
        b=R0CuAkDlRj/epsCtNDiO769hiBOguzKFe+DAO8MOds8DX2VlHRtmw3lNcLg1khZm/I
         0OYbo3y1YmRr3DWOHUPC3VO+LKCpSBtIQlTsbOEbrbHUrT5frl/+Zjw/feqjxNer7C3j
         gEKmBWa6Jy/ij4WIWEoq1zfN//SoOc5iwURF5lCocD/B48nTK9DrbB+oyH65TnprnOZp
         bu4RtGxZCEFmKmTU2tgnCO8H2i/36mK2azwddE2iSqLZPM76RCO9wzIA6Pg2hLGPE5n2
         kX2osXwsAr+x535KbmZvxFbCKo+oOdZF63FpJbChHcGjAjbbqzONAaQ46/zG9edbLLlR
         kshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pOGkUpEQFpFLpHbYfDTTEGGqLarAut/n6gfwvOUJSSs=;
        b=CnHGj4nLpGD53UJ9SNUuTZkL+RU54uB8fjoHVFNj6Be0IZntaF3GML4R1TyINIvjoO
         YpLab0QYeMIXMP+kexdD1y8qmBvYr3+8P60Owcj1G9Pvac3KzEC0kte0tjwi22AXhPMb
         O7i5Tg7H4SLRjo+Zcc+hw1OLoOMOufe5aILRYG/kHA+ByQGvmnGrj6ns1OKL33GVPmi6
         oe35Ak5mkrJ6TOpUAchXVJbUVFUGMwMhq9J1U11QSYaY0nNM173odtTm/9Cde02OWfay
         QaZt2wgOs+1Q+btvzjlZDnonb7RZh+nlpkigEUPenUhGz1Fwvcocwih5Pja6v/4B/HRn
         qmCQ==
X-Gm-Message-State: AOAM531+FAaoYjGYAeaS5X/AiW1t1gjy5LrGQ/yRJXWEFeGLy4Fnxjrl
        o/8igkDnRvMFgQW8hoTxVCE6ug==
X-Google-Smtp-Source: ABdhPJzZWGAZNTQelf6KybogENzY/nGSEIm8ur8Obr1OHpGzBzHe9kVOd445QBOnfVWYevvhTxUksg==
X-Received: by 2002:a19:c70f:: with SMTP id x15mr5758531lff.296.1604337405683;
        Mon, 02 Nov 2020 09:16:45 -0800 (PST)
Received: from gmail.com (wireless-nat-78.ip4.greenlan.pl. [185.56.211.78])
        by smtp.gmail.com with ESMTPSA id b18sm2485747lfp.89.2020.11.02.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:16:45 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:16:43 +0100
From:   =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201102171643.GA5870@gmail.com>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102122638.GB23988@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/20, Jan Kara wrote:
> Strange. Thanks for report. Looks like some issue got created / exposed
> somewhere between 5.5 and 5.9 (actually probably between 5.5 and 5.7
> because the Linaro report you mentioned [1] is from 5.7-rc6). There were
> no changes in this area in fanotify, I think it must have been some x86
> change that triggered this. Hum, looking into x86 changelog in that time
> range there was a series rewriting 32-bit ABI [2] that got merged into
> 5.7-rc1. Can you perhaps check whether 5.6 is good and 5.7-rc1 is bad?

5.6 works.
5.7-rc1 doesn't work.

-- 

Paweł Jasiak
