Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8F258A97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgIAIoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 04:44:39 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:38910 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIAIoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:44:37 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 8046CA00D7;
        Tue,  1 Sep 2020 10:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1598949875;
        bh=mIdANwWwlPqHszzYGjhQKPmy/JsZ+HrTUgoApsidgoY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hgJzV6bbgTlG6jqkhi4G/K86n/3yxvlWgkaIxznqz/g03TnZpxBUf5V6impw8wE+S
         HCuYNUHOmAQxJ7F1ihLVdNHeK6I8xK/JG9LNmPtoK1rf5XJoTDPR1krxDh5i04phrI
         YQHWNRRSjTghnlmtZvgDNYl8L3cUh3GLPirE+++o=
Subject: Re: [PATCH v4] video: fbdev: ssd1307fb: Added support to Column
 offset
To:     b.zolnierkie@samsung.com
Cc:     Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <d15729dd-63d1-7a06-f957-22eab6d74c9f@ysoft.com>
Date:   Tue, 1 Sep 2020 10:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 07. 20 22:22, Rodrigo Alencar wrote:
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.
> 
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

Hi Bartlomiej,
what is the status of this patch? I would like to see this merged so I can send
patches for our in-tree imx6dl-yapp4 device trees that need exactly this change.

Thank you,
Michal
