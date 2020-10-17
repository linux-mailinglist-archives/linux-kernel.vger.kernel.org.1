Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07D291134
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437972AbgJQJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 05:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437934AbgJQJu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 05:50:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3C6206CB;
        Sat, 17 Oct 2020 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602928226;
        bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0I8V70NPjkVG0T/yckTy/XSDbkFypgo3HivKVihL3mgKKKuPKDx0rfJ8382Q7NRAG
         vMFTMXTiXa1jjMEkOTxsEAk35JN8EVE0XxqBMjqme7ob8kq/Ipzi1x3joXxULqiZO4
         Cxr28QQvlBG+7DeHnLyaOVK0++AXqRFZYibrL+Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.9.1
Date:   Sat, 17 Oct 2020 11:51:08 +0200
Message-Id: <1602928267147112@kroah.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1602928267189102@kroah.com>
References: <1602928267189102@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

