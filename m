Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D32B300A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKNTQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:16:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:43501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgKNTQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605381402;
        bh=BaU9B24vchJVY0osYWnl5oKDqq6cigXHVzOWtlYrlcI=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=lDFv0F9RF06EARLqNLPewv2MJiHFP5ZCncYxyNYwkZmAkh/ZFV5EOuUOxD05UKzhq
         TXC6DCAUxrWhy2VO7JHiyidwT72HhHTLUiy/c6IKkJQ4eRipZy4NOW/cH3iVXiTjLi
         5BhpW7CyxBj2/HUJRdvSIhLPXfxrH6IvL0EQKCso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.100] ([185.6.148.154]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1jwfsZ3jGc-00iipw for
 <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 20:16:42 +0100
Message-ID: <5be77264b98c271668935e4b6ff0d8d558e8298b.camel@gmx.com>
Subject: Re: Suggestion: Lengthen the review period for stable releases from
 48 hours to 7 days.
From:   Hussam Al-Tayeb <ht990332@gmx.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 14 Nov 2020 21:16:33 +0200
In-Reply-To: <17c526d0c5f8ed8584f7bee9afe1b73753d1c70b.camel@gmx.com>
References: <17c526d0c5f8ed8584f7bee9afe1b73753d1c70b.camel@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CzKssYpYQN+RjyoCibL0H3rdoOgujUV14+wfuHCHaKN3avs6QVv
 9sHSC276L6bcFz+CBbH8Mn8kQ0OGGOs/yPL5BmpVq3gycg/nkEAsQo1L4oRd0meqoIp7JaK
 6zfy5RIphwgIBmVJbuQX/Nl0nWZKKKjXEAKoHu2i2nlx6H4QlOodM4ZF3gR0CTHZzUACBm8
 +pUdVDfFN1ZfIIjI3oW6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sgw6hSpMwAQ=:vYfPZmINk7KgKGfC4SVxd9
 fpQYwxzF3FYO2XtnRSrWgfv/+hUJYAh160docfMua1ZGcu6nI6kVBCXqpzL8tMuIIPI+ZDtCN
 5q7IF32vEzJXaGpoSoqCWNpcbM5xqeL0dZuVUDm1xYkGJLOBmiX1MQJ4+7HwBQ+xYPwcQ0nz4
 Y2K6hG0NCNidl6KoVYplBxAkqHgHTmwbSnhlA3uKDAJukbz6JxtN77IR9VrBiV1zdhU66B97D
 WWAgxn8OHm1V4/el2m35qqXsnlRxarevZa4DpPvDLhNI0gLjUa6HKL7gUovPLKsH+Y3CNCPoO
 0aBgaJbWiYspDdF0bHFxAI12gqmnF4Ohy1eB7G4XAOOhydzxLbkIMa7umKEngVgVWgeUVA2wn
 Mu0k/hcXJraYWNnW8MwNoWv2y0sJIYqBGJVqb6HCc4p6n03k3vpxfove7Zkv9jC4F0K0QpdGe
 3EuJ7PHR6f1enrGPdrtNISJHXkUqDA2khLsptbz7Spk8kHdxu8kjhy0C0XceeA+gPuMZ+wBuM
 D7rf43yesotsea5e41BR0fVL99Ujp9ejNVtv2fIVk5HLmYOrB9q+4Dcwo6LsnENAju7IHZfu7
 qaypnXeDxoz7QbosKj5pYXbfIvX5SHUdq8JrO5yTnTiOQ/vANZgHmgYVM8awsKww7BqurILv/
 D9/0QwbxkPOMGSBhA5R+MbndyMcwsTb6d1U6hDxYZiB1187GLGJxYtwV9ah9CfztMHNpM9GKY
 2mzfQGiHrR7ubrWyXlmubDct/gK0eZGoWeK1DgrVcOYMXM7Aoswo7PKLaiW53pv7vNHafg2SK
 V9DrARzvu9NJzgDtseHYAX9EeeVO0nDl0mvMNi2ZmZbpW43FaPV1/VWrL7fCgceM1cD8eDlDl
 0gCl/CFj54HjLGGnENGX7SfvzEe5QtkrCEa2vs+SE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-14 at 17:40 +0200, Hussam Al-Tayeb wrote:
> Hello. I would like to suggest lengthening the review period for
> stable
> releases from 48 hours to 7 days.
> The rationale is that 48 hours is not enough for people to test those
> stable releases and make sure there are no regressions for particular
> workflows.
> This is especially important for companies deploying those kernels in
> production machines. Often those releases are on weekends as well
> further limiting the ability to test.
> It is of course possible to skip stable updates that have large
> numbers
> of patches and only update once a month but I feel a longer testing
> period will work best for everyone.
> It is, of course, always possible to exempt urgent security releases
> from the waiting period.
>
> Thank you.
> Hussam.
>

One more note. This is not a random internet rant. I actually do need
more than 48 hours to test new stable kernels and I believe others do
too.
Regards,
Hussam.

