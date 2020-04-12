Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B81A5F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgDLPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgDLPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 11:50:06 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 11:50:05 EDT
Received: from mailgw-02.dd24.net (mailgw-02.dd24.net [193.46.215.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C9C0A3BF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:42:33 -0700 (PDT)
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 7897C5FF7F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 15:42:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id iVyKSVNqqReV for <linux-kernel@vger.kernel.org>;
        Sun, 12 Apr 2020 15:42:29 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-42-14.dynamic.mnet-online.de [88.217.42.14])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 15:42:29 +0000 (UTC)
Message-ID: <401217bf3f840f66ab84ed290213570d551a699f.camel@scientia.net>
Subject: Re: great CPU temperature increase from 5.2 to 5.5 ... and when
 using intel_pstate
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-kernel@vger.kernel.org
Date:   Sun, 12 Apr 2020 17:42:29 +0200
In-Reply-To: <ce8097694ddfab616616f8f81521495d99c74416.camel@scientia.net>
References: <ce8097694ddfab616616f8f81521495d99c74416.camel@scientia.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.

Well it seems no one cares about such a heave regression ... event
though it's quite clearly proven by the plots.
Perhaps it's just normal that Linux suddenly runs 10-40°C hotter.

Is there any subproject in the kernel which deals with such issues?


Thanks,
Chris.

