Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD27D2D0CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLGJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:27:52 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49737 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgLGJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:27:46 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 6F03BD41;
        Mon,  7 Dec 2020 04:26:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Dec 2020 04:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/nsmhG1xJBQajktap+F4GzFz+sv
        UmEY+Nhy6ctweVCk=; b=pAnQvHgzHVWzYg41Qk5gdlxuAvA/t/Lv8Wl4UutEr8E
        Yh92taTO5Csi51G6g1o5BO28X6C66afV8TUdRPyYa9A7X42xImkS2zXjGIsBrNsJ
        aXW+QGm3UYTE07Iodv2y3Wm8paKBnZCJ1tj9LkgiAbtLWJT+P+PQyUt1rGXJ8Xl5
        VkNAMi3SD2HVbDpvoC1I5XRD+/z+k3X9rijUnGJJSK63dE/crO1MpL702xMq7i5W
        AUEntt/P1ff5j9TrYaQ13wFIhg0WzK+hcDyd5sUNZ7yJj0smt0LOVv+qujiTIzt1
        gMsArr+u7ybWFab9AuRdo6hESdbDBFdiUw/++ggfFOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/nsmhG
        1xJBQajktap+F4GzFz+svUmEY+Nhy6ctweVCk=; b=Z+z/HpaA/Mn8JFQJJW8M0E
        0ErArAP5P6H/OLJieS5Vvrpg6UH9ETd0jubV0KqhEsXp8X/XuqV7sier/ZgxQUIA
        I4oKZb2gdZopAgarLUi5UqAfPKoyn7Rv7CwV/JgY1NLfzf7xZhpZnUCeEE2jvGWg
        5QFb+Ui62lJ/mITBvTbJc++K+Whchb39hxq62Z8Hzc/qYfhP5bTDN5QJERfeMpmz
        O0rRFIdc9+iBECyYJOFRElJx0bemh74hQivRXNf92Vjefd9TTpGhoivfgJ4UOrkB
        nswq1pd6+tiX/gEmDX+SoiH9yqshiqGQf3aGHP8B/TGmXKqWhIQ/znRWTxRkx3nA
        ==
X-ME-Sender: <xms:SPXNX5-13vy9g3kjS0KZJXGLtHBSSRtQBrCbNKOFxRraCNu-sZ2BVw>
    <xme:SPXNXyAaLLBGEmpUwo-RRPqz8n8IEmt1lrDzmNNDizVgCee11DuzHDBThtHzpTzVY
    rQJKrNRwHfMEOXAA98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepiedvhfdtgfeggfelfffgteeiveevhfdtvdfhheefgfffhfeuhfdtueefvefh
    ledvnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukf
    hppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:SPXNX2KSVFOew2ivZe6E34P-UKDa_rCQqX6qktgI84_bPbEno0wnTQ>
    <xmx:SPXNX1lXsBY3ZxgvuRt0lsS9VUjMm4V1SDNt6ftGcy_RSpXr18hQEg>
    <xmx:SPXNX0EvGQDS_AtV3BgZ3V_p_5MV-Mzr-3v8UFpNAeBvFFsAP35Wig>
    <xmx:SvXNX0fb2sMZnkG_egvwxp_CRzQ2e8_t3FoehIjEeMoSES6Txxf_ig>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 658C6108005B;
        Mon,  7 Dec 2020 04:26:32 -0500 (EST)
Date:   Mon, 7 Dec 2020 10:26:31 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201207092631.gkqd7mfnyjg3tcx5@gilmour>
References: <cover.1607094989.git.wilken.gottwalt@posteo.net>
 <c03d114477b887048ea0348dbfd1adb53c139e9f.1607094989.git.wilken.gottwalt@posteo.net>
 <20201204162117.u7fevtxkktuiqncv@gilmour>
 <20201204180725.62698c50@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eeo6enb4xs6ong6s"
Content-Disposition: inline
In-Reply-To: <20201204180725.62698c50@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eeo6enb4xs6ong6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2020 at 06:07:25PM +0100, Wilken Gottwalt wrote:
> On Fri, 4 Dec 2020 17:21:17 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > On Fri, Dec 04, 2020 at 04:35:12PM +0100, Wilken Gottwalt wrote:
> > > Adds the sunxi_hwspinlock driver for the hardware spinlock unit found=
 in
> > > most of the sun8i and sun50i based SoCs.
> > >=20
> > > This unit provides at least 32 spinlocks in hardware. The implementat=
ion
> > > supports 32, 64, 128 or 256 32bit registers, where one lock can be ta=
ken
> > > by reading a register and released by writing a 0 to it. This driver
> > > supports all 4 spinlock setups, but for now only the first setup (32
> > > locks) seem to exist in available devices. This spinlock unit is shar=
ed
> > > between all ARM cores and the embedded OpenRisc AR100 core, all of th=
em
> > > can take/release a lock with a single cycle operation. It can be used=
 to
> > > sync access to devices shared by the ARM cores and the OpenRisc core.
> > >=20
> > > There are two ways to check if a lock is taken. The first way is to r=
ead
> > > a lock. If a 0 is returned, the lock was free and is taken now. If an=
 1
> > > is returned, the caller has to try again, which means the lock is
> > > currently taken. The second way is to read a 32bit wide status regist=
er
> > > where every bit represents one of the 32 first locks. According to the
> > > datasheets this status register supports the 32 first locks only. For
> > > this reason the lock read/write approach is used in this driver which
> > > can cover all 256 locks in the biggest setup.
> > >=20
> > > Being able to use the status register to get knowledge about the locks
> > > makes it suitable to extended testing. It also can be used to bypass
> > > the Linux hwspinlock ABI completely and is not able to set locks. This
> > > is used in one of the tests to show that the driver works correctly.
> > >=20
> > > To run all tests it is necessary to take locks on the OpenRisc core a=
nd
> > > show on the Linux side that the locks were taken by an external event.
> > > This can be achived by using the crust firmware. For this the crust
> > > firmware needs to be changed to take and release spinlocks (a simple
> > > MMIO operation on the hwlock registers), which is currently not
> > > supported by the current crust firmware. The necessary crust fork can
> > > be found here https://github.com/wgottwalt/crust (hwspinlock branch).
> > > It is also necessary to build u-boot with support for this crust/SCP
> > > firmware. This u-boot fork can be found here
> > > https://github.com/crust-firmware/u-boot (crust branch). For testing
> > > this driver it is also necessary to pick a device that is fully
> > > supported by crust. In this case a H5 based device works very well. In
> > > this test a Friendlyarm NanoPi NEO2 was used, which is fully supported
> > > by u-boot (also the fork) and current Linux kernels. In the crust fork
> > > it is necessary to go into debug menu of "make nconfig" and select the
> > > hwspinlock test loop, which uses the timeout functions of the crust
> > > firmware. It loops through the first 32 spinlocks and takes/releases a
> > > lock one after another using a timeout which can be set in the debug
> > > menu.
> > >=20
> > > Test 1:
> > > This test was done with a mainline u-boot and a crust enabled u-boot.
> > > For this a simple second kernel module was used, found here
> > > https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/test_module.
> > >=20
> > > If run with mainline u-boot it shows that the Linux side correctly
> > > takes a lock, tries to recursively take a lock again (which does not
> > > happen) and releases a lock. Done for all 32 locks several times.
> > >=20
> > > [  122.518435] [init]--- SUNXI HWSPINLOCK DRIVER TEST ---
> > > [  122.523810] [run ]--- testing locks 0 to 31 ---
> > > [  122.528370] [test] testing lock 0
> > > [  122.531686] [test]+++ attempt #0 succeded
> > > [  122.535709] [test]+++ attempt #1 succeded
> > > [  122.539729] [test]+++ attempt #2 succeded
> > > [  122.543752] [test] testing lock 1
> > > [  122.547072] [test]+++ attempt #0 succeded
> > > [  122.551093] [test]+++ attempt #1 succeded
> > > [  122.555113] [test]+++ attempt #2 succeded
> > > [  122.559129] [test] testing lock 2
> > > ...
> > > [  123.004812] [test] testing lock 31
> > > [  123.008208] [test]+++ attempt #0 succeded
> > > [  123.012228] [test]+++ attempt #1 succeded
> > > [  123.016250] [test]+++ attempt #2 succeded
> > >=20
> > > Same test run with the hwspinlock test loop enabled in crust. Here the
> > > test module hits two locks exactly in the moment crust switches from
> > > lock 7 to 8. The test module code path is slower because of more code
> > > that needs to be executed which makes this rare scenario possible.
> > >=20
> > > [  122.620656] [test] testing lock 6
> > > [  122.623966] [test]+++ attempt #0 succeded
> > > [  122.627988] [test]+++ attempt #1 succeded
> > > [  122.632008] [test]+++ attempt #2 succeded
> > > [  122.636044] [test] testing lock 7
> > > [  122.639364] [test] taking lock attempt #0 failed (-16)
> > > [  122.644507] [run ]--- testing specific lock 7 failed (-14) ---
> > > [  122.650345] [test] testing lock 8
> > > [  122.653671] [test] taking lock attempt #0 failed (-16)
> > > [  122.658818] [run ]--- testing specific lock 8 failed (-14) ---
> > > [  122.664658] [test] testing lock 9
> > > [  122.667971] [test]+++ attempt #0 succeded
> > > [  122.671989] [test]+++ attempt #1 succeded
> > >=20
> > > Test 2:
> > > This is a more complex test that uses the status register to bypass t=
he
> > > Linux hwspinlock ABI. For this to work a slightly modified driver is
> > > used and can be found here
> > > https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/
> > > modified_sunxi_hwspinlock
> > > This modified driver splits the 4K memory range into two and leaves t=
he
> > > status register untouched, so that it can be used by another test ker=
nel
> > > module which can be found here
> > > https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/test2_module
> > > It is also necessary to change the device tree entries to get both
> > > kernel modules working in parallel.
> > >=20
> > > hwspinlock-mod@1c18000 {
> > >         compatible =3D "allwinner,sun50i-hwspinlock-mod";
> > >         reg =3D <0x01c18000 0x4 0x01c18100 0x400>;
> > >         clocks =3D <&ccu CLK_BUS_SPINLOCK>;
> > >         clock-names =3D "ahb";
> > >         resets =3D <&ccu RST_BUS_SPINLOCK>;
> > >         reset-names =3D "ahb";
> > >         status =3D "okay";
> > > };
> > >=20
> > > hwspinlock-stat@1c18010 {
> > >         compatible =3D "allwinner,sun50i-hwspinlock-stat";
> > >         reg =3D <0x01c18010 0x4>;
> > >         status =3D "okay";
> > > };
> > >=20
> > > The extended test kernel module supports 4 different modes of the tes=
t,
> > > 2 of them are sufficient to show the spinlock mechanism working.
> > >=20
> > > Mode 1:
> > > This one reads and prints the status register continuously. The crust
> > > firmware and the test are set to a hwlock timeout of 1 second. The te=
st
> > > kernel module code runs a bit slower because of more code executed and
> > > you can see how one lock is missed between entry 2 and 3.
> > >=20
> > > > modprobe sunxi_hwspinlock_test2 mode=3D1 loops=3D10
> > > [  187.167074] [init]--- SUNXI HWSPINLOCK DRIVER TEST ---
> > > [  187.172636] [sreg] 00000000_00010000_00000000_00000000
> > > [  188.196287] [sreg] 00000000_00001000_00000000_00000000
> > > [  189.220285] [sreg] 00000000_00000010_00000000_00000000
> > > [  190.244286] [sreg] 00000000_00000001_00000000_00000000
> > > [  191.268285] [sreg] 00000000_00000000_10000000_00000000
> > > [  192.292294] [sreg] 00000000_00000000_01000000_00000000
> > > [  193.316302] [sreg] 00000000_00000000_00100000_00000000
> > > [  194.340285] [sreg] 00000000_00000000_00010000_00000000
> > > [  195.364285] [sreg] 00000000_00000000_00001000_00000000
> > > [  196.388284] [sreg] 00000000_00000000_00000100_00000000
> > >=20
> > > Mode 3:
> > > This mode combines the Linux hwspinlock ABI approach from test 1 and =
the
> > > status register access. The "after" reads show the locks taken by the
> > > Linux driver and the crust firmware.
> > >=20
> > > [  439.138476] [test] testing lock 13
> > > [  439.141894] [sreg] before take 00000000_00000100_00000000_00000000
> > > [  439.148083] [sreg] after take 00000000_00000110_00000000_00000000
> > > [  439.154189] [sreg] after recursive take 00000000_00000110_00000000=
_00000000
> > > [  439.161162] [sreg] after untake 00000000_00000010_00000000_00000000
> > > [  439.167435] [test]+++ attempt #0 succeded
> > > [  439.171458] [sreg] before take 00000000_00000010_00000000_00000000
> > > [  439.177649] [sreg] after take 00000000_00000110_00000000_00000000
> > > [  439.183751] [sreg] after recursive take 00000000_00000110_00000000=
_00000000
> > > [  439.190725] [sreg] after untake 00000000_00000010_00000000_00000000
> > > [  439.196992] [test]+++ attempt #1 succeded
> > > [  439.201018] [sreg] before take 00000000_00000010_00000000_00000000
> > > [  439.207212] [sreg] after take 00000000_00000110_00000000_00000000
> > > [  439.213322] [sreg] after recursive take 00000000_00000110_00000000=
_00000000
> > > [  439.220290] [sreg] after untake 00000000_00000010_00000000_00000000
> > > [  439.226559] [test]+++ attempt #2 succeded
> > > [  439.230576] [test] testing lock 14
> > > [  439.233996] [sreg] before take 00000000_00000010_00000000_00000000
> > > [  439.240177] [test] taking lock attempt #0 failed (-16)
> > > [  439.245322] [run ]--- testing specific lock 14 failed (-14) ---
> > > [  439.251252] [test] testing lock 15
> > > [  439.254677] [sreg] before take 00000000_00000010_00000000_00000000
> > > [  439.260865] [sreg] after take 00000000_00000011_00000000_00000000
> > > [  439.266975] [sreg] after recursive take 00000000_00000011_00000000=
_00000000
> > > [  439.273943] [sreg] after untake 00000000_00000010_00000000_00000000
> > > [  439.280212] [test]+++ attempt #0 succeded
> > > [  439.284235] [sreg] before take 00000000_00000010_00000000_00000000
> > > [  439.290428] [sreg] after take 00000000_00000011_00000000_00000000
> > > [  439.296534] [sreg] after recursive take 00000000_00000011_00000000=
_00000000
> > > [  439.303502] [sreg] after untake 00000000_00000010_00000000_00000000
> > > [  439.309774] [test]+++ attempt #1 succeded
> >=20
> > Most of this should be in the cover letter (the details on how to make =
the tests mostly).
> >=20
> > However, I mentioned in your first version that some comments on the
> > previous drivers posted still applied to you, and you missed those
> > comments apparently. See here for more details:
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200210170=
143.20007-2-nborisov@suse.com/#23148161
> >=20
> > Most importantly, the driver name and compatible need to be changed.
>=20
> Hmm, so I basically could use sun8i or sun50i. But picking sun8i would be
> the logical one, because there it appeared first and sun50i is backwards
> compatible... What do you think?

Yep, for the driver names and compatibles we go for the earliest
SoC/family that had that design. The 64 bits SoC came after the A33, so
sun8i it is :)

(And yes, your tests are fine by me, thanks!)

Maxime

--eeo6enb4xs6ong6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX831RgAKCRDj7w1vZxhR
xWmKAP9h7IOCmOSGHHoX8oKqk19raFi8GVn4mQKs21MbhikPegEAtUt+rX40QUuG
2DjalepjUApOOwO1QccXAwMQqnJg6QM=
=A9mc
-----END PGP SIGNATURE-----

--eeo6enb4xs6ong6s--
