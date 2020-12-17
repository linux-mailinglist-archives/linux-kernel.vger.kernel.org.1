Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15D52DD58F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgLQQ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:57:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:37793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQQ53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608224152;
        bh=c0PHT/TGtjHfuIdfwbbLYZ4BFjPZ6wV6q0w2OaDOfOQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=dIpw1EMrBmjlWPZRTLkwhTEYE/KNsbQfede19koJ79Vg1r+xqgByTv8i8tx6/30Bs
         x5l9qypGF0frL05vX877GBhB0byofEgF1yLQEQNqMazl435XbwWS9AVzgowOzANOmE
         sXrE2iA9Qhb+Vl/Ht0x9YNnoq/rHz5gxkbN8TVj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1kD2qL0MgH-00fECf; Thu, 17
 Dec 2020 17:55:52 +0100
Message-ID: <b84976b575676ad6ddb495a74087229aeec4d117.camel@gmx.de>
Subject: Re: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
From:   Mike Galbraith <efault@gmx.de>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Airlie <airlied@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Date:   Thu, 17 Dec 2020 17:55:51 +0100
In-Reply-To: <7cb43d5b-4e6a-defc-1ab6-5f713ad5a963@amd.com>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
         <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
         <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
         <6f99d3ca-a7ff-69e9-8ca1-9d016a8d3f48@amd.com>
         <23bc1073395db9ccf55ecca45198375f4d5d6250.camel@gmx.de>
         <7cb43d5b-4e6a-defc-1ab6-5f713ad5a963@amd.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WaqrFesBWE7MAabYptFLLhYagqZZiQDKrj3xWOx/T2LQISwqsOo
 1B+wbsHhmKdp60rSeJ+7bf2cdRVe08Nt5dK9QeW3qofuTR8ArAS8C9Bpt5+njpqTmGRWwDB
 vN2FSQT8qoBrevoi4l0kV8BXd/g92pxAY6E+BctB7M+Gf3R2J6h02rK1Na1VTFKKOOEfohM
 +mYWGWCPTlYNfZel94rYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zr+ombKlrdQ=:6A+/WfAIWi08aIWV+/Nus7
 0ZXoXJUyQinRakWNl6FaLh9Zfv3iynJCDGtt1R5quZcR+PRYdQHV1TwiRi8R0aXLnaf7+jt2h
 Snlez/u8i0SAdvmJVIBxRWWQW8RFD3tjVv9KrV+6BQLL5TxNRLS0mkdbECpBfoZZ20M8sc12m
 PwpmFAsYiCNcoD8z6ex2EtnJ0467V7nWLFgOkcPQy5SsMa/vO7ZZmPYz+6RTqxAexDu3j5bto
 LB8SUuht/N40p/eCvV3S8dAXeSxU4mwukdmEmPsemBGb1OhoW9o07OHLTB92duH8Lxzs7neQF
 +Vkxy7YXq4T4Z7g3upTUwqUA2Q3+4EcEJuHga+2wiz/GH6RV59tI+hPZGFA2xawKPXMffj2rt
 J5pXDn9mE0NuRIGajMY4EUvpgevxtvRybKBEscJXDuDictq85OV1WdB8mJQPljCm8lnIcTlFa
 W2wpcMVkTBhbO1ZU+4wYFSOpibYQVoT/FKJytRDsXBE1G89ZULQVaEFuIplglQ+7rvo29H/RU
 0bp0b14nJCFpxhpnZ2ENK95iMzQrLBQL8hWwV473i9eBOajC+BAe1G/1dyqpuXkmLX4jQSG74
 Kf+eHuF9VgraXyf9seWmRGwhzH32hTj4DWIq7hHsq9cOo3NXOkCvMNqfAl1oRImSIuhF39hj0
 4Nt75hIHSkFbDZLzmBHfBlTiHT9S2ER02sXeyuNVkHGROZ1/yt7WNtGjvgtmtmk5CWayFeh2+
 p7zc933AQ9YNswoFPxPYxw3p0kFfarD8yGN/8yPBjUjAWwqXzSXEyUC+o6h99h33J0oV67oBO
 RpRdCQQjIDm5oGLL6kIQ6WM1hxXjVMaZ3Dj5zTjxdn1wRMHYA/Tj3tIBo6+mFWTmAEr+3kdKb
 Dnxom02UGLHFGR6UHagg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 17:38 +0100, Christian K=F6nig wrote:
>
> Mike can you test the attached patch?

Yup, one-liner made it all better. That was quick like bunny.

	-Mike

