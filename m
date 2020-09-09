Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3826254C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 04:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgIICkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 22:40:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:34037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgIICkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599619161;
        bh=7JR4k3M+f91YpKQkJyCiYOLKXQWgm9AD9avtoW/wwn8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PD2foST8q8hykP0jVDeAuTelc3wEKIcJ6Lh2iwwlc+WQpMkiTw5j2+2DsXv/xgym3
         YEsrODh4o3UlcS5TZ+y1+UXrjSJADGCyBQ6K2lZ0DJDo2QedEMqV3LSISLWfU5nJ/D
         sizzTqVvHP/REHavk+9zf8tlsbOc5WljT86xvH24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1jvASq2Zmv-00NUwB; Wed, 09
 Sep 2020 04:39:21 +0200
Message-ID: <fb56b88424482baca8a2f178092a0de634256c59.camel@gmx.de>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 09 Sep 2020 04:39:20 +0200
In-Reply-To: <20200908150612.6qlygag7e7pzhr22@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
         <20200908121902.zlfd3balosnu7ies@linutronix.de>
         <3471761a379062a474ba32f9d0157eb3020244cf.camel@gmx.de>
         <20200908150612.6qlygag7e7pzhr22@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ve4zNWrfY1ZdbKJPjsbxxp4H+fkftsXodXClmEfoxh92vdoNwVk
 jNDJ5ftnKRJvoivQDEUFa4y3KyCXZ21MZF1vq4XFbDAbI9Tk20Rw7WaOC1dL6DdtNIyH/Y4
 F0Tbyb808MFMOGTCYyFDD6pMtd5jEy34AyuVbHERRV3+7NAUI3O0CKOBlWdwUUyrlMLQ1qF
 rke+faN4Gu6+XoHfOcxZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:94VbXjfdyNs=:bAoK3I3lJT+v57nnMdfXwv
 iP5e4hNZMW45S3dAzHORon3+RTqeEENR/M53+41gYHR1teDXPXch/9F8jTco1xeIQIQWZkDJR
 UjU23SIzsX6mVs2I/XQ4RoQROKTbpLOula9FvtgJe/eBZgHweYd7LwxrWiC97LdPKyv7DgoHJ
 Y+ef3vmB7lDzhDkv30jINlIYGocjVvazVDR31AKtStznwZruD553oddNfl3Ccq6f4cY11C4Zb
 KTUptK2b0eqQkNYDh5/FZrl04qRlbuoBZVW6YnRCjs9VmGy7pzMILUJb+rRUCLGHfGZ9YHuC+
 LC0pdIyFXwQCZmz4x0YfvmuEJXhxWxjALDaHC6tI5vGYYrV8aQCjmdhKjAVqV/yI5Ejzmabrk
 tWOnZHPXDmywFKtmeLeWMw6yUH+WJXJdHC8p98cUsKhNjkzmnCvHXlt0Nh1aLypBVfKeW1vne
 epst72kzlPArH+6fIp69NwQct5ezckrlouhOwdohctYrf4IZIzwoaNhlRShVBvEbNUBlGKvkg
 vWwVfvkcbtXOSv7KylKuadFPhCZqItJQXA31m0UNCi5iZNK+RvYmY9qWMQVABj5jhWCP6yhID
 jsl9lgvVFSxcocH/XcEwPYbxRsw82QIC1rUDDKnGPCCy562qWX6b38JDsoxViYxuEjZPWdbRf
 pdQ6eQ3R0fLjnkk9cGTg7rGBXlqk5PCQd4xGtY4n8WBEbBJbsebWz+jZJSKFCh5qQRTsqjIjN
 7W7Kh/2zYKY/fhE1sOZwy8gtEv2qG89gWHrRvPRtzUICKjYNinTmZTbi3XQQAfu6B+YIe20U2
 35Ra2nAI2WuKdoxQtjCrKj43G9uker11Jci4yuWSZ90VGc8AFp7kXVbHnJZZrPJlwri31saOa
 ouc0bXGjPKxylqsKdOerL43MdrA+u65RJci1GItmPXqVjSwA7qjpl42slDPGK453tNwn641xA
 OMNHxuhqx3AtNcgAotxGpICkAetkwIDyxq9YnNCBuNwn6/e+yQxXoudOzkMSyssPM+YF/QECW
 CAYGI+nZJok++fAsrNwJsZfYw09+gw3wlO5nrj0byv6W6njjw2XRW/GVTAAJSDvZR3jX1Oj79
 FSDuCdkEWY+JHpQVEWlQuUl+7Jj4IHJw2SC++lQpJECPjo28gnkeaszZEnI0bX+32zKXuvtpU
 fURc63etiM/c4VmjSBOcMg8b9T6oTxxp2fbCvozDOvHhzSoq8wVfMw4RE5V/yXumAEn1EuHwu
 uj8k9sc2mWAxHmr2T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-08 at 17:06 +0200, Sebastian Andrzej Siewior wrote:
>
> This should cure it:

It did.

	-Mike

