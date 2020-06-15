Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F011F9F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 20:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgFOS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:26:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A49C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:26:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h10so4210447pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P1CWugv8At4hoVY78lLsRp7X7dhFYtlRoortuxpcFCw=;
        b=d4tyeDMohBRQ95CjvrZa6a3+G5shGbMCWFcuSB+duOdfRy9Pt43tofQfuONPluWDzq
         Y52t3/oDUaKP4VApXovO52uKEQn8ft7lABCeu60XYLM/dmrKckMGbgAwvuCza81Q5AuW
         amgFl5xx7Xe+oWtAuFd128UTX9Wpe+rpowOi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1CWugv8At4hoVY78lLsRp7X7dhFYtlRoortuxpcFCw=;
        b=YGCOlIxhDPsbssVPetzBogQfsQxV+mMnLb5y2m6NZnlO4z7a/jYWTBN3LWs+devylL
         CutaBOS3vZxWR03c5jyNj00ghjuRADj6OTfLL7GfwuEtkTQGkIVeTUisZf6OLGSZnoE/
         zeMpDtsiKGTAbT9kZVfOrUY8UQjEn8mz6olsbcicPcUdcHjPFDlEESh1ZyzgzoRKl1RL
         1sYliTlFfJPMXJUkDjJ7xPY7/iJq8nP38hzshluNXiEe/DkzKaG3l3fm0K4tRnQ+7TkO
         WXTY6bCEMdnwR5qO/JTArkfiaWPk+TkQfpRPbvkgmLVNki/m2gy4nYFxYpsJBpB/1NNg
         QSDQ==
X-Gm-Message-State: AOAM5320OdOE7fXifKd5vDb/xnHhogFjLbifwWR2/pCO3XX9k8BIGlXH
        lM7xpNQLXX/D7UkVCVuXoF4RtQ==
X-Google-Smtp-Source: ABdhPJymNtZha2b6DlF+o2cuid6oldIXzcsTAHGSwyobWdMly7LM/sU6qxJmnQfd1hAfaOhf4OjK4Q==
X-Received: by 2002:a62:3806:: with SMTP id f6mr24228613pfa.102.1592245606547;
        Mon, 15 Jun 2020 11:26:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm15158205pfk.8.2020.06.15.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:26:45 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:26:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] seccomp: Add extensibility mechanism to read
 notifications
Message-ID: <202006151125.5FAE400D0@keescook>
References: <20200613072609.5919-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613072609.5919-1-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 12:26:09AM -0700, Sargun Dhillon wrote:
> This introduces an extensibility mechanism to receive seccomp
> notifications. It uses read(2), as opposed to using an ioctl. The listener
> must be first configured to write the notification via the
> SECCOMP_IOCTL_NOTIF_CONFIG ioctl with the fields that the user is
> interested in.

FYI: I'm not ignoring this, but I'm trying to get the other series
nailed down first. I'll cycle back around to this soon.

-- 
Kees Cook
