Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF021B4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 08:15:59 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55835 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgGJMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:15:58 -0400
Received: from webmail.gandi.net (webmail23.sd4.0x35.net [10.200.201.23])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay11.mail.gandi.net (Postfix) with ESMTPA id D807C10000D;
        Fri, 10 Jul 2020 12:15:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Jul 2020 15:15:55 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3] kdb: remove unnecessary null check of dbg_io_ops
In-Reply-To: <CAD=FV=XbMfwAQ+M7oMksd0dv9xjkQrGhU8hVNahn7+vxTuhT6A@mail.gmail.com>
References: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
 <20200630082922.28672-1-cengiz@kernel.wtf>
 <CAD=FV=XbMfwAQ+M7oMksd0dv9xjkQrGhU8hVNahn7+vxTuhT6A@mail.gmail.com>
Message-ID: <4b91d92eda95cf4f1e153544ff4c17e1@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 2020-07-01 01:32, Doug Anderson wrote:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Wanted to ask about the status of this proposed patch.

I have checked your tree in git.kernel.org but you might be
collecting them somewhere else perhaps.

Thank you for your time

-- 
Cengiz Can
@cengiz_io
