Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38E19D5BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbgDCLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 07:22:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47916 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgDCLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:22:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 033BMTlS054465;
        Fri, 3 Apr 2020 06:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585912949;
        bh=PM+AhtxYL8OtN6RVrUe4Aud0OCilJ08Spz+//NcGSSo=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=LX/saJbSiPlMMK0+U8H28CJ8jhgysYcPvqDDpuOgpnjJQGeDY+6dVxiFfS/5xNd3S
         pb/bdwI1IFzHTLoL8WGy2z5yElxgkip+omt00uUkszMGzTi0HVVRQOoJPHUOJ3hIM5
         Ol9E02MDuCckiLtU5CIHCT/VFcIcVr/0XlcgbdWc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 033BMT5R060972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Apr 2020 06:22:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Apr
 2020 06:22:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Apr 2020 06:22:29 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033BMRHj024794;
        Fri, 3 Apr 2020 06:22:28 -0500
Subject: Re: [v5.4.28-rt19] ARM64: nfs boot issues
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Nori, Sekhar" <nsekhar@ti.com>
References: <0d05e716-5575-d4bd-64be-187c85244c12@ti.com>
Message-ID: <08852afc-16f4-d2c3-7f52-37181d341232@ti.com>
Date:   Fri, 3 Apr 2020 14:22:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0d05e716-5575-d4bd-64be-187c85244c12@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2020 18:06, Grygorii Strashko wrote:
> Hi All,
> 
> We now observe NFS boot issues with TI RT Kernel (last merged tag v5.4.28-rt19) on TI (ARM64) AM654x/J721E platforms.
> It's just stack (100%) silently right after Kernel init (log1) or in the middle of the boot (log2).
> 
> I'm trying to investigate an issue and I'd like to ask if anybody else observed the same?
> 

Sorry for disturbing you it was IRQ driver issue.

-- 
Best regards,
grygorii
