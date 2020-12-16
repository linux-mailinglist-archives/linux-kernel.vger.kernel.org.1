Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E989D2DC279
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgLPOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:50:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:40139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgLPOu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608130161;
        bh=mvvzD9twTIBU6Dg1SodbMbRzNXnlPIHQmM98R36uvbs=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=e5PcY7ZjwCkuu+qYhUP5KCLd9TbzV/D3/BDgwJTPL1uXa2DsyfbYw6KbEcI8Ipawh
         eDxIg1YMScSqck22mWsqNotBvRH98CK6Zh0VOrTOgSVsvXtIFkpcpfWLpeEJ+9jnb1
         N72PwfK//ucCQvYXaTviKrnKf++nwNDNEBfkH1wY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1jzmLO0Nh1-00syse; Wed, 16
 Dec 2020 15:49:21 +0100
Message-ID: <c3132ac7e0536a30aefc833df16f5a24de7e4529.camel@gmx.de>
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
From:   Mike Galbraith <efault@gmx.de>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Date:   Wed, 16 Dec 2020 15:49:17 +0100
In-Reply-To: <19b5ee604512d09bc4b059b7e59d73681937048a.camel@gmx.de>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
         <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
         <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
         <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
         <19b5ee604512d09bc4b059b7e59d73681937048a.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dmRn1Rw/NtUu4u47a6u98t0rxeL8gS1z4Ii/m99+EI7N6vpFpkc
 1KpNDestwCOBvnOHNbfsRiLusEPfr9HFHRyyjsxxmWBiLrAGiai40UtUYQqimYXGPRynxdp
 YxcJw/zTtW1DQ+05e5NoYpgFFsj9PjAbPQfKb9qiaUNDGrTQBnLlfTKS3sa3/cFpW4LKerw
 odUnfX8benDJ/cs3HkMGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ulaw/v9vr5E=:vXZthj/ZG2PXP/DIFILDeH
 gQLuk9AZvKTVlrySghbXeqa0BFYJvtLF7ywlBfTGL3grWoaZlyty8Uq/Z8Sse1X5jaWOTTgbt
 uWkQVfS+Qd83wuZyzDJc0GeQV/iM0anmjZMpu1MKbVHo2bUu0L68HFPQUl/loIUiMTNlEw8R+
 FVLNaq/rGxl8TIzJfevlvn3Bmt4sJ3wCbZ8vYeeFM18CES/MM95lDJKBfhHdCvNRN21LlKFJc
 fRNfzugnmlEmF9oYoZq1gTWU0AP4iSinrLsSVTOcN9AAirUeuhCEad7eOukTJ7Q9E1cG2o6sP
 UCRXkqz4R4++IQhEZd8z4afwtb7IXsX27szjVPbiprfzs3iPDv1Mc4PfDUAoZ/k7ySOI55BQi
 TE3GXHNJ/19yoZfnXIBhmQ8syD9Q3c6431AQdnjlHNcNkxtTh3nN2Usq6QFVnaWgQNyfmAGBJ
 4bGRneIqzEAiXO/npxyPvdCVDqVSZgc8sFKvv1xFOSY5nbxOSpQikyWBQtJtT06aG1xkCPKH8
 9kZAjztXSeITovmOI6IqPB7nFhiB6AJ1pqkBDlM4M3vVq/Wz1WSCiRCloR6vu34EOPVZbn+UW
 ttfz2tPjtfXgNTjLLOSMTINDLV77USE2rSyhd7XshsO/BT8ZA9WnyXJjUwLwY2uzvHHpEcKgH
 nnfsdvn5Gcg9we/fqvCWDXorlF3TSS8HZoFi42y3wjAgihlojIeBqjjS4OxMkTBY7RsBZAFc1
 GnxGMgCxDPvGNktMAYrEG659KEVWlxSijx8FkDJSumgBep0dFur+8wD0kcMoo3vb5KeadSKwZ
 0vWohM6MQA3seuzGhgXRETLggK5UxMaCt/zIXzc8amm5ZjFpLlzH8XTdwuxTK+d0xUge0U2GL
 CZYPqzH3QawLExolTuqA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-16 at 15:31 +0100, Mike Galbraith wrote:
> On Wed, 2020-12-16 at 17:23 +0300, Kirill Tkhai wrote:
> >
> > Does this regression only cause that one error message "check_release:=
 Can't get the kernel version"
> > is printed instead of another: "The kernel version is not supported."?
>
> The thing does indeed mutter about the kernel version, with or without
> 9a56493f6942 reverted, but it work despite the muttering with
> 9a56493f6942 reverted.

makedumpfile 1.6.7 source only claims to work up to linux-5.4.8, but
actually does work all the way up until 9a56493f6942.

If the answer here is that v1,6,7 has reached EOL, that's fine, I'll
just carry a revert until I can cobble together an updated package.

	-Mike

